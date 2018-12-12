# frozen_string_literal: true

module Etna
  module Components
    # Converts a Typhoeus::Response into an Api::Responses::X kind of response
    class Response
      extend Forwardable

      attr_reader :response, :error, :body, :request, :exception, :response_data

      def_delegators :@response, *(Typhoeus::Response.instance_methods - Object.instance_methods - %i[body request status code])

      def initialize(typhoeus_response, request)
        @response = typhoeus_response
        @response_data = @response.options.merge({ headers: typhoeus_response.headers })
        @request = request.to_h

        @error = !typhoeus_response.success?

        @exception = nil
        @body = parse_body!.tap do |parsed_body|
          if parsed_body.is_a?(Responses::ApiJsonParseError)
            @error = true
            @exception = parsed_body
          end
        end
      end

      def status
        @response.code
      end

      def code
        @response.return_code
      end

      def process
        errored ? factor_error : factor_response
      end

      def error?
        !success?
      end

      def collection?
        body.is_a?(Array)
      end

      def to_h
        {
          status: status,
          code: code,
          body: @body,
          total_time: total_time,
          response: @response,
          request: @request,
        }
      end

      private

      def errored
        @error
      end

      def parse_body!
        response.body.empty? ? {} : JSON.parse(response.body)
      rescue ::JSON::ParserError => exception
        Responses::ApiJsonParseError.new(exception, self)
      end

      def factor_response
        if collection?
          Responses::Collection.new(self)
        else
          Responses::Entity.new(self)
        end
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def factor_error
        return @exception if @exception

        return factor_auth_error if status == 401

        case status
        when 0
          Responses::ApiTimeoutError.new(self, "Request timed out in #{@response.total_time}")
        when 300, 301, 302, 303, 307
          Responses::ApiRedirectionError.new(self)
        when 400
          Responses::ApiBadRequestError.new(self)
        when 403
          Responses::ApiForbiddenError.new(self)
        when 404
          Responses::ApiNotFoundError.new(self, 'Not found')
        when 405
          Responses::ApiMethodNotAllowedError.new(self)
        when 409
          Responses::ApiResourceConflictError.new(self)
        when 422
          Responses::ApiUnprocessableEntityError.new(self)
        when 423..499
          Responses::ApiClientError.new(self)
        when 500..599
          Responses::ApiServerError.new(self)
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity

      def error_code
        body['errors'].map { |e| e['code'] }.uniq.first
      end

      def factor_auth_error
        case error_code
        when 'invalid_token'
          Responses::ApiUnauthorizedError.new(self, 'Invalid Token')
        when 'invalid_client'
          Responses::ApiInvalidPartnerCredentialsError.new(self, 'Invalid Client Key and Secret')
        end
      end
    end
  end
end

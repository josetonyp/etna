# frozen_string_literal: true

module Etna
  module Components
    # Converts a Typhoeus::Response into an Api::Responses::X kind of response
    class Responder

      def self.factor(typhoeus_response, request)
        factor_error(typhoeus_response, request) || factor_response(typhoeus_response, request)
      end

      private

      def self.factor_response(typhoeus_response, request)
        Etna::Components::Response.new(typhoeus_response, request)
      rescue ::JSON::ParserError => exception
        Errors::JsonParseError.new(typhoeus_response, request, exception, "There was an error parsing the given response")
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def self.factor_error(typhoeus_response, request)
        case typhoeus_response.code
        when 0
          Errors::ApiTimeout.new(typhoeus_response, request, "Request timed out in #{typhoeus_response.total_time}")
        when 300, 301, 302, 303, 307
          Errors::ApiRedirection.new(typhoeus_response, request)
        when 400
          Errors::ApiBadRequest.new(typhoeus_response, request)
        when 403
          Errors::ApiForbidden.new(typhoeus_response, request)
        when 404
          Errors::ApiNotFound.new(typhoeus_response, request, 'Not found')
        when 405
          Errors::ApiMethodNotAllowed.new(typhoeus_response, request)
        when 409
          Errors::ApiResourceConflict.new(typhoeus_response, request)
        when 422
          Errors::ApiUnprocessableEntity.new(typhoeus_response, request)
        when 423..499
          Errors::ApiClient.new(typhoeus_response, request)
        when 500..599
          Errors::ApiServer.new(typhoeus_response, request)
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity
    end
  end
end

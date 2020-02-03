# frozen_string_literal: true

module Etna
  module Components
    class Response
      extend Forwardable

      attr_reader :response, :error, :body, :request, :exception, :response_data

      def_delegators :@response, *(Typhoeus::Response.instance_methods - Object.instance_methods - %i[body request status code])

      def initialize(typhoeus_response, request)
        @response = typhoeus_response
        @request = request
        @body = parse_body
      end

      def status
        @response.code
      end

      def code
        @response.return_code || Etna::Components::HTTP_CODES[@response.code]
      end

      def error?
        !success?
      end

      def type
        if response.headers["Content-Type"].match(/json|javascript/)
          :json
        else
          :text
        end
      end

      def to_h
        {
          status: status,
          code: code,
          body: body,
          type: type,
          total_time: total_time
        }
      end

      protected

      def parse_body
        if response.headers["Content-Type"].match(/json|javascript/)
          response.body.empty? ? {} : ::JSON.parse(response.body)
        else
          response.body
        end
      end

    end
  end
end

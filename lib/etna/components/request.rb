# frozen_string_literal: true

module Etna
  module Components
    class Request
      def initialize(logger: nil, headers: {}, timeout: 60)
        @logger = logger
        @headers = headers
        @timeout = timeout
      end

      def build(url:, method:, body: nil, options: {}, headers: {})
        @url = url
        @request_params = {
          method:          method,
          body:            body,
          params:          options.fetch(:params, {}),
          headers:         @headers.merge(headers),
          timeout:         options.fetch(:timeout, @timeout),
          accept_encoding: 'gzip',
          maxredirs:       0,
        }
        self
      end

      def execute
        typhoeus_request = Typhoeus::Request.new(@url, @request_params)

        result = nil

        typhoeus_request.on_complete do |response|
          result = response
        end

        typhoeus_request.run

        result
      end

      def to_h
        {
          url: @url,
          params: @request_params,
        }
      end
    end
  end
end

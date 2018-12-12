# frozen_string_literal: true

module Etna
  module Components
    module Responses
      class ApiError < StandardError
        include Etna::Concerns::ApiResponse

        def initialize(api_response, message = nil, caller_backtrace: caller)
          @response = api_response.response_data
          @request = api_response.request

          @status = api_response.status
          @code = api_response.code

          @error = api_response.error?

          @body     = api_response.body
          @time     = api_response.total_time

          @message = message || 'There where an error on the API'
          super(@message)
          set_backtrace(caller_backtrace)
        end

        def error?
          true
        end

        def success?
          false
        end

        def detail
          server_detail = @body&.fetch('errors', [])&.map { |e| e['detail'] }.join("\n")
          server_detail.empty? ? @message : server_detail
        end

        def title
          @body&.fetch('errors', [])&.map { |e| e['title'] }.join("\n")
        end

        def to_h
          {
            id:     uid,
            status: @status,
            code:   code,
            title:  title,
            detail: detail,
            url:    @request[:url],
            body: @body,
            method: @request[:params][:method],
            server_response: @response,
            server_request: @request,
            backtrace: backtrace,
          }
        end
        alias to_log to_h
      end
    end
  end
end

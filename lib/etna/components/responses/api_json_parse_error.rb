# frozen_string_literal: true

module Etna
  module Components
    module Responses
      # The json response is not readable
      class ApiJsonParseError < StandardError
        include Etna::Concerns::ApiResponse

        def initialize(exception, api_response, _message = nil, caller_backtrace: caller)
          @response = api_response.response_data
          @request = api_response.request

          @status = 499
          @code = :json_parse_error

          @error = true

          @body     = {}
          @time     = api_response.total_time

          @message = exception.message
          super(@message)

          set_backtrace(caller_backtrace)
        end

        def to_h
          {
            id:     uid,
            status: @status,
            code:   code,
            title:  title,
            detail: title,
            url:    @request[:url],
            method: @request[:params][:method],
            server_response: @response,
            server_request: @request,
            backtrace: backtrace,
          }
        end

        def title
          'Json Parse Error'
        end
      end
    end
  end
end

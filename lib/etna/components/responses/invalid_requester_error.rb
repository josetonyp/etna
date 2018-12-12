# frozen_string_literal: true

module Etna
  module Components
    module Responses
      # The json response is not readable
      class InvalidRequesterError < StandardError
        include Etna::Concerns::ApiResponse

        def initialize(api_request, caller_backtrace: caller)
          @response = {}
          @request = api_request.to_h

          @status = 600
          @code = :invalid_requester

          @error = true

          @body     = {}
          @time     = 0

          @message = 'The provided request id (person_id) is not present or invalid'
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
          'Invalid Requester Error'
        end
      end
    end
  end
end

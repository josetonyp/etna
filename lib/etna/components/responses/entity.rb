# frozen_string_literal: true

module Etna
  module Components
    module Responses
      class Entity
        include Etna::Concerns::ApiResponse

        def initialize(api_response)
          @response = api_response.response_data
          @request = api_response.request
          @body = api_response.body

          @error = api_response.error?

          @status = api_response.status
          @code = api_response.code

          @time = api_response.total_time
        end

        def to_h
          {
            id:     uid,
            status: @status,
            code:   code,
            body:   @body,
            url:    @request[:url],
            method: @request[:params][:method],
            server_response: @response,
            server_request: @request,
          }
        end
        alias to_log to_h
      end
    end
  end
end

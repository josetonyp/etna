# frozen_string_literal: true

module Etna
  module Components
    module Responses
      class Collection
        include Etna::Concerns::ApiListResponse

        def initialize(api_response)
          @response = api_response.response_data
          @request = api_response.request
          @collection = api_response.body

          @error = api_response.error?

          @status = api_response.status
          @code = api_response.code

          @time     = api_response.total_time

          @per_page = @response[:headers].fetch('Per-Page', 0).to_i
          @total = @response[:headers].fetch('Total', 0).to_i
          @current_page = @response[:headers].fetch('Current-Page', 1).to_i
          @page_total = @collection.count.to_i
        end

        def to_h
          {
            id:     uid,
            status: @status,
            code:   code,
            body:   body,
            url:    @request[:url],
            method: @request[:params][:method],
            server_response: @response,
            server_request: @request,
          }
        end

        def body
          {
            collection: @collection,
            per_page: @per_page,
            total: @total,
            current_page: @current_page,
            page_total: @page_total,
          }
        end
        alias to_log to_h

        def to_a
          @collection
        end
      end
    end
  end
end

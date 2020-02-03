# frozen_string_literal: true

module Etna
  module Components
    module Errors
      class JsonParseError < Base

        attr_reader :message, :exception, :backtrace

        def initialize(typhoeus_response, request, exception, message = nil, caller_backtrace: caller)
          @response = typhoeus_response
          @request = request

          @status = 499
          @code = :json_parse_error
          @body     = {}

          @exception = exception
          @backtrace = exception.backtrace
          @message = exception.message
        end

        def error?
          true
        end

        def type
          :standard_error
        end

        def to_h
          {
            status: @status,
            code: @code,
            body: @body,
            type: type,
            total_time: total_time
          }
        end
      end
    end
  end
end

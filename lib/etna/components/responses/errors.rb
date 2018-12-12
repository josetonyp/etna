# frozen_string_literal: true

require_relative 'api_error'

module Etna
  module Components
    module Responses
      # rubocop:disable Style/CommentedKeyword
      class ApiConnectionError < ApiError; end           # 0
      class ApiRedirectionError < ApiError; end          # 301, 302, 303, 307
      class ApiBadRequestError < ApiError; end           # 400
      class ApiUnauthorizedError < ApiError; end         # 401
      class ApiInvalidPartnerCredentialsError < ApiError; end # 401 When Partner is not valid to get a new token
      class ApiForbiddenError < ApiError; end            # 403
      class ApiNotFoundError < ApiError; end             # 404
      class ApiMethodNotAllowedError < ApiError; end     # 405
      class ApiResourceConflictError < ApiError; end     # 409
      class ApiUnprocessableEntityError < ApiError; end  # 422
      class ApiClientError < ApiError; end               # 400..499
      class ApiServerError < ApiError; end               # 500..599
      class ApiTimeoutError < ApiError; end              # timeout
      # rubocop:enable Style/CommentedKeyword
    end
  end
end

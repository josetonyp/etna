# frozen_string_literal: true

module Etna
  module Components
    module Errors
      # rubocop:disable Style/CommentedKeyword
      class ApiConnection < Base; end           # 0
      class ApiRedirection < Base; end          # 301, 302, 303, 307
      class ApiBadRequest < Base; end           # 400
      class ApiUnauthorized < Base; end         # 401
      class ApiInvalidPartnerCredentials < Base; end # 401 When Partner is not valid to get a new token
      class ApiForbidden < Base; end            # 403
      class ApiNotFound < Base; end             # 404
      class ApiMethodNotAllowed < Base; end     # 405
      class ApiResourceConflict < Base; end     # 409
      class ApiUnprocessableEntity < Base; end  # 422
      class ApiClient < Base; end               # 400..499
      class ApiServer < Base; end               # 500..599
      class ApiTimeout < Base; end              # timeout
      # rubocop:enable Style/CommentedKeyword
    end
  end
end

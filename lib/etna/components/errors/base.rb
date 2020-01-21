# frozen_string_literal: true

module Etna
  module Components
    module Errors
      class Base < Etna::Components::Responses::Base
        attr_reader :message

        def initialize(typhoeus_response, request, message = nil)
          @response = typhoeus_response
          @request = request
          @message = message || "There was an error on the API: #{@response.return_code}"
        end
      end
    end
  end
end

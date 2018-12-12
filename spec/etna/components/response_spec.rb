# frozen_string_literal: true

require 'spec_helper'

module Etna
  # Converts a Typhoeus::Response into an Api::Components::Responses::X kind of response
  RSpec.describe Components::Response do
    include_context 'Typhoeus responses'

    it 'parses the json into a Hash' do
      response = Components::Response.new(valid_auth_response, example_request)
      expect(response.status).to eq(201)
      expect(response.code).to eq(:ok)
      expect(response.body).to have_key('access_token')
      expect(response).to respond_to(:process)
    end
  end
end

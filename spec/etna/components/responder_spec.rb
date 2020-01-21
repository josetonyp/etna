# frozen_string_literal: true

require 'spec_helper'

module Etna
  # Converts a Typhoeus::Response into an Api::Components::Responses::X kind of response
  RSpec.describe Components::Responder do
    include_context 'Typhoeus responses'
    subject { Components::Responder }

    context "#factor" do
      it 'returns a proper error if the Typhoeus response is an error' do
        subject.factor(non_valid_api_response, example_request).tap do |response|
          expect(response).to be_a(Etna::Components::Responses::Base)
          expect(response.status).to eq(404)
          expect(response.code).to eq(:ok)
          expect(response.message).to eq("Not found")

          expect(response).to be_error
          expect(response).not_to be_success
        end
      end

      it "returns a json response if the Typhoeus is a valid response" do
        subject.factor(valid_collection_response, example_request).tap do |response|
          expect(response).to be_a(Etna::Components::Responses::Base)
          expect(response.status).to eq(200)
          expect(response.code).to eq(:ok)

          expect(response).not_to be_error
          expect(response).to be_success
        end
      end
    end
  end
end

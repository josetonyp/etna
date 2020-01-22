# frozen_string_literal: true

require 'spec_helper'

module Etna
  # Converts a Typhoeus::Response into an Api::Components::Responses::X kind of response
  RSpec.describe Components::Responder do
    let(:valid_request) do
      request = Components::Request.new(headers: { 'Accept-Encoding' => 'application/json', 'Content-Type' => 'application/json'})
      request.build(method: :get, url: "https://api.coindesk.com/v1/bpi/currentprice.json")
    end

    let(:invalid_request) do
      request = Components::Request.new(headers: { 'Accept-Encoding' => 'application/json', 'Content-Type' => 'application/json'})
      request.build(method: :get, url: "https://api.coindesk.com/v1/xlm/currentprice.json")
    end

    subject { Components::Responder }

    context "#factor" do
      it 'returns a proper error if the Typhoeus response is an error' do
        subject.factor(invalid_request.execute, invalid_request).tap do |response|
          expect(response).to be_a(Etna::Components::Response)
          expect(response).to be_a(Etna::Components::Errors::Base)
          expect(response.status).to eq(404)
          expect(response.code).to eq(:ok)
          expect(response.message).to eq("Not found")

          expect(response).to be_error
          expect(response).not_to be_success
        end
      end

      it "returns a json response if the Typhoeus is a valid response" do
        request = Components::Request.new(headers: { 'Accept-Encoding' => 'application/json', 'Content-Type' => 'application/json'})
        request.build(method: :get, url: "https://api.coindesk.com/v1/bpi/currentprice.json")

        subject.factor(valid_request.execute, valid_request).tap do |response|
          expect(response).to be_a(Etna::Components::Response)
          expect(response.status).to eq(200)
          expect(response.code).to eq(:ok)
          expect(response.body).to be_a(Hash)

          expect(response).not_to be_error
          expect(response).to be_success
        end
      end
    end
  end
end

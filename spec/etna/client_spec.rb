# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Client do
    include_context 'Typhoeus responses'

    let(:api_response) { unauthorized_auth_response }
    let(:client) { described_class.new(base_url) }

    before do
      Typhoeus.stub(%r{^*.\/any_request$}) { api_response }
    end

    context 'not authorized request' do
      it 'returns a ApiInvalidPartnerCredentialsError when the request is not authorized' do
        response = client.get('/any_request')
        expect(response).to be_a(Components::Responses::ApiInvalidPartnerCredentialsError)
      end
    end

    context 'Collections response' do
      let(:api_response) { valid_collection_response }

      it 'converts the request into a collection response' do
        response = client.get('/any_request')
        expect(response).to be_a(Components::Responses::Collection)
      end
    end

    context 'Entity response' do
      let(:api_response) { valid_entity_response }

      it 'returns an entity on case of single response' do
        response = client.get('/any_request')
        expect(response).to be_a(Components::Responses::Entity)
      end
    end

    context 'timed out request' do
      let(:api_response) { timed_out_response }

      it 'has a configurable timeout request' do
        client = described_class.new(base_url)

        response = client.get('/any_request', timeout: 0.01)
        expect(response).to be_a(Components::Responses::ApiTimeoutError)
      end
    end

    describe '.run' do
      [
        :get, :post, :patch, :delete
      ].each do |method|
        context "when called by #{method} alias" do
          subject { client.send(method, 'url', 'body', 'options', 'header') }

          it 'propagates body to execute' do
            expect(client).to(receive(:execute).with(method, 'url', 'body', 'options', 'header'))
            subject
          end
        end
      end
    end
  end
end

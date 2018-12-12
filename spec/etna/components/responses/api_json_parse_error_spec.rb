# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Responses::ApiJsonParseError do
    include_context 'Typhoeus responses'

    subject { Components::Response.new(invalid_json_response, example_request).process }

    describe 'raw reponse' do
      subject { Components::Response.new(invalid_json_response, example_request) }

      it 'has status 200 and code :ok' do
        expect(subject.status).to eq(200)
        expect(subject.code).to eq(:ok)
      end
    end

    describe 'processed response' do
      describe '#to_h' do
        it 'returns a hash with the status, title, details and body of the response' do
          subject.to_h.tap do |error_hash|
            expect(error_hash[:status]).to eq(499)
            expect(error_hash[:code]).to eq(:json_parse_error)
            expect(error_hash[:detail]).not_to be_nil
            expect(error_hash[:method]).to eq(:get)
            expect(error_hash[:server_response]).to be_a(Hash)
            expect(error_hash[:server_request]).to be_a(Hash)
          end
        end
      end

      describe '#success?' do
        it 'sign the object as an error object' do
          expect(subject).not_to be_success
          expect(subject).to be_error
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Responses::ApiTimeoutError do
    include_context 'Typhoeus responses'

    subject { Components::Response.new(timed_out_response, example_request).process }

    describe 'raw reponse' do
      subject { Components::Response.new(timed_out_response, example_request) }

      it 'has status 0 and code :operation_timedout' do
        expect(subject.status).to eq(0)
        expect(subject.code).to eq(:operation_timedout)
      end
    end

    describe 'processed response' do
      describe '#to_h' do
        it 'returns a hash with the status, title, details and body of the response' do
          subject.to_h.tap do |error_hash|
            expect(error_hash[:status]).to eq(0)
            expect(error_hash[:code]).to eq(:operation_timedout)
            expect(error_hash[:detail]).to match(/Request timed out in/)
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

# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Responses::Base do
    include_context 'Typhoeus responses'

    subject { Components::Responses::Base.new(valid_collection_response, example_request) }

    context '#to_h' do
      it 'returns a hash with the status, title, details and body of the response' do
        subject.to_h.tap do |h|
          expect(h[:status]).to eq(200)
          expect(h[:code]).to eq(:ok)
          expect(h[:body]).to eq(subject.body)
          expect(h[:type]).to eq(:json)
          expect(h[:total_time]).not_to be_nil
        end
      end
    end

    context '#success?' do
      it 'sign the object as a success object' do
        expect(subject).to be_success
        expect(subject).not_to be_error
      end
    end

    context '#type' do
      it 'returns the response content type' do
        expect(subject.type).to eq(:json)
      end
    end
  end
end

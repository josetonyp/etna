# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Responses::Entity do
    include_context 'Typhoeus responses'

    subject { Components::Response.new(valid_entity_response, example_request).process }

    describe '#to_log' do
      it 'returns a log with the status, title, details and body of the response' do
        subject.to_h.tap do |entity_object|
          expect(entity_object[:status]).to eq(200)
          expect(entity_object[:code]).to eq(:ok)
          expect(entity_object[:method]).to eq(:get)
          expect(entity_object[:server_response]).to be_a(Hash)
          expect(entity_object[:server_request]).to be_a(Hash)
        end
      end
    end

    describe '#success?' do
      it 'sign the object as a success object' do
        expect(subject).to be_success
        expect(subject).not_to be_error
      end
    end

    describe 'forwards methods to body' do
      it 'forwards all hash methods to the api_response body' do
        expect(subject['id']).to eq(subject.body['id'])
      end
    end
  end
end

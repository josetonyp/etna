# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Responses::Collection do
    include_context 'Typhoeus responses'

    subject { Components::Response.new(valid_collection_response, example_request).process }

    context '#to_h' do
      it 'returns a hash with the status, title, details and body of the response' do
        subject.to_h.tap do |collection_object|
          expect(collection_object[:status]).to eq(200)
          expect(collection_object[:code]).to eq(:ok)
          expect(collection_object[:method]).to eq(:get)
          expect(collection_object[:body]).to eq(subject.body)
          expect(collection_object[:server_response]).to be_a(Hash)
          expect(collection_object[:server_request]).to be_a(Hash)
        end
      end
    end

    context '#success?' do
      it 'sign the object as a success object' do
        expect(subject).to be_success
        expect(subject).not_to be_error
      end
    end

    context 'forwards methods to body' do
      it 'forwards all hash methods to the api_response body' do
        expect(subject.collection).to be_a(Array)
        expect(subject.first['id']).to eq(subject.collection.first['id'])

        expect(subject.body[:per_page]).to eq(10)
        expect(subject.body[:total]).to eq(20)
        expect(subject.body[:current_page]).to eq(1)
        expect(subject.body[:page_total]).to eq(10)
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Response do
    let(:request) do
      request = Components::Request.new(headers: { 'Accept-Encoding' => 'application/json', 'Content-Type' => 'application/json'})
      request.build(method: :get, url: "https://api.coindesk.com/v1/bpi/currentprice.json")
    end

    subject { Components::Response.new(request.execute, request) }

    context '#to_h' do
      it 'returns a hash with the status, title, details and body of the response' do
        subject.to_h.tap do |h|
          expect(h[:status]).to eq(200)
          expect(h[:code]).to eq(:ok)
          expect(h[:body]).to eq(subject.body)
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
# frozen_string_literal: true

# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Components::Request do
    it 'wrap the request into a Typhoeus::Request request' do
      request = Components::Request.new
      request.build(url: 'http://www.example.com', method: :get)

      expect(Typhoeus::Request).to receive(:new).and_call_original

      request.execute
    end

    it 'has a serialization to Hash method' do
      request = Components::Request.new
      request.build(url: 'http://www.example.com', method: :get)

      expect(request.to_h).to eq({ url: 'http://www.example.com', params: { method: :get, body: nil, params: {}, headers: {}, timeout: 60, accept_encoding: 'gzip', maxredirs: 0 } })
    end
  end
end

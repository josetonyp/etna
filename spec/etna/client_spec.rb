# frozen_string_literal: true

require 'spec_helper'

module Etna
  RSpec.describe Client do
    let(:headers) { { 'Accept-Encoding' => 'application/json', 'Content-Type' => 'application/json'} }
    let(:client) { described_class.new("https://api.coindesk.com") }
    subject { client.get("/v1/bpi/currentprice.json", {}, {}, headers) }

     context 'non error response' do
      it 'converts the Typhoeus request into a Etna request' do
        expect(subject).to be_a(Components::Response)
      end
    end

    context 'error response' do
      it 'returns an etna error object' do
        expect(subject).to be_a(Components::Errors::Base)
      end
    end

    describe '#run' do
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

# frozen_string_literal: true

require 'spec_helper'

module Etna
  class TestingClient < Etna::Client
    include Etna::Concerns::Logger

    
  end

  RSpec.describe Concerns::Logger do
    include_context 'Typhoeus responses'

    let(:logger) { ::Logger.new(IO::NULL) }
    let(:client) { TestingClient.new('http://www.example.com', logger: logger) }
    let(:collection) { Components::Response.new(valid_collection_response, example_request).process }
    let(:entity) { Components::Response.new(valid_entity_response, example_request).process }
    let(:error) { Components::Response.new(invalid_json_response, example_request).process }
    let(:person_info) { { person: { person_id: 'askldiryqo34q98yrt' } } }

    it 'logs a valid collection' do
      log = client.send(:log_content, collection, person_info)
      expect(log).to have_key(:person)
      expect(log).to have_key(:server_request)
      expect(log).to have_key(:server_response)
      expect(log).to have_key(:status)
      expect(log).to have_key(:code)
    end

    it 'logs a valid entity' do
      log = client.send(:log_content, entity, person_info)
      expect(log).to have_key(:person)
      expect(log).to have_key(:server_request)
      expect(log).to have_key(:server_response)
      expect(log).to have_key(:status)
      expect(log).to have_key(:code)
    end

    it 'logs a valid error' do
      log = client.send(:log_content, error, person_info)
      expect(log).to have_key(:person)
      expect(log).to have_key(:server_request)
      expect(log).to have_key(:server_response)
      expect(log).to have_key(:status)
      expect(log).to have_key(:code)
    end

    it 'sends the information to the logger' do 
      expect(logger).to receive(:info).with(any_args)
      client.send(:log, error, person_info)
    end
  end
end

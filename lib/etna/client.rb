# frozen_string_literal: true

module Etna
  class Client
    # This client is forcing all body request to be JSON format then qualify itself a JSON client
    # beside all communication with this API is JSON by default
    def initialize(base_url, logger: nil, timeout: 60)
      @base_url = base_url
      @logger = logger
      @timeout = timeout
    end

    def execute(method_name, url, body = {}, options = {}, headers = {})
      request = Components::Request.new(headers: headers, logger: @logger, timeout: @timeout)
      request.build(method: method_name, url: @base_url + url, body: body.to_json, options: options)

      request = before_request(request)

      result = request.execute
      response = Components::Responder.factor(result, request)

      after_response(response)

      response
    end

    def run(url, body = {}, options = {}, headers = {})
      execute(__callee__, url, body, options, headers)
    end

    alias get run
    alias post run
    alias patch run
    alias delete run

    protected

    def before_request(request)
      request
    end

    def after_response(response); end
  end
end

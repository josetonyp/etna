# frozen_string_literal: true

module Etna
  class Client
    # This client is forcing all body request to be JSON format then qualify itself a JSON client
    # beside all communication with this API is JSON by default
    def initialize(base_url)
      @base_url = base_url
    end

    def execute(method_name, url, body = {}, options = {}, headers = {})
      request = Components::Request.new(headers: headers)
      request.build(method: method_name, url: @base_url + url, body: body.to_json, options: options, headers: headers)

      request = before_request(request)

      result = request.execute
      response = Components::Response.new(result, request).process

      after_response(response)

      response
    end

    def run(url, body = {}, options = {}, headers = {})
      execute(__callee__, url, body = {}, options = {}, headers = {})
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

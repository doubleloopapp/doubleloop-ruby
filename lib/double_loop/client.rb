# frozen_string_literal: true

require "net/http"
require "json"

module DoubleLoop
  # HTTP client to interact with the API
  class Client
    def self.post(resource, params) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      uri = URI("#{DoubleLoop.endpoint}#{resource}")
      headers = {
        "Content-Type": "application/json"
      }
      request = Net::HTTP::Post.new(uri, headers)
      request.body = {
        **params,
        api_token: DoubleLoop.api_token
      }.to_json

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = DoubleLoop.endpoint.start_with?("https")
      response = https.request(request)

      case response
      when Net::HTTPSuccess
        JSON.parse(response.read_body)
      else
        raise DoubleLoop::Error, response.body
      end
    rescue EOFError, Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::EHOSTUNREACH, Errno::ETIMEDOUT, SocketError
      raise DoubleLoop::ConnectionError
    end
  end
end

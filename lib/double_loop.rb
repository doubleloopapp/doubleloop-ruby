# frozen_string_literal: true

require_relative "double_loop/object"
require_relative "double_loop/client"
require_relative "double_loop/errors"
require_relative "double_loop/event"
require_relative "double_loop/metric"
require_relative "double_loop/version"

# The main DoubleLoop root module
module DoubleLoop
  ENDPOINT = "https://app.doubleloop.app/api"

  class << self
    attr_accessor :api_token, :endpoint
  end
end

DoubleLoop.endpoint = DoubleLoop::ENDPOINT

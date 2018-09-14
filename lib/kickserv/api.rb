# frozen_string_literal: true

require File.expand_path('http_utils/request', __dir__)
require File.expand_path('http_utils/response', __dir__)
require File.expand_path('http_utils/connection', __dir__)

module Kickserv
  # Kickserv HTTP API Handler Implementation
  class API
    include HttpUtils::Request
    include HttpUtils::Response
    include HttpUtils::Connection

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options = {})
      options = Kickserv.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end
  end
end

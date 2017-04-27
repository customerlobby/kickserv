require File.expand_path('../request', __FILE__)
require File.expand_path('../response', __FILE__)
require File.expand_path('../connection', __FILE__)

module Kickserv
  class API

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
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

    include Request
    include Response
    include Connection
  end
end

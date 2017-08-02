require 'faraday'
require 'faraday_middleware'
require 'active_support/all'
require "kickserv/version"

require File.expand_path('../kickserv/configuration', __FILE__)
require File.expand_path('../kickserv/api', __FILE__)
require File.expand_path('../kickserv/client', __FILE__)

module Kickserv
  extend Configuration
  # Alias for Kickserv::Client.new
  # @return [Kickserv::Client]
  def self.client(options = {})
    Kickserv::Client.new(options)
  end

  # Delegate to Kickserv::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end
end

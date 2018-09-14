# frozen_string_literal: true

module Kickserv
  module Configuration
    VALID_OPTIONS_KEYS = %i[
      api_key
      api_version
      adapter
      account_slug
      endpoint
    ].freeze

    # By default don't set the api key.
    DEFAULT_API_KEY = nil

    # By default don't set the account slug.
    DEFAULT_ACCOUNT_SLUG = nil

    # By default use V1 of the API.
    DEFAULT_API_VERSION = nil

    # Use the default Faraday adapter.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default use the main api URL.
    DEFAULT_ENDPOINT = 'kickservapp.com'.freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # When this module is extended, reset all settings.
    def self.extended(base)
      base.reset
    end

    # Reset all configuration settings to default values.
    def reset
      self.api_key      = DEFAULT_API_KEY
      self.api_version  = DEFAULT_API_VERSION
      self.endpoint     = DEFAULT_ENDPOINT
      self.account_slug = DEFAULT_ACCOUNT_SLUG
      self.adapter      = DEFAULT_ADAPTER
    end
  end
end

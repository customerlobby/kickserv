# frozen_string_literal: true

module Kickserv
  # Wrapper for the Kickserv HTTP API.
  class Client < API
    require File.expand_path('../models/customer', __FILE__)
    require File.expand_path('../models/job', __FILE__)

    include Kickserv::Models::Customer
    include Kickserv::Models::Job
  end
end

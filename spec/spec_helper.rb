# frozen_string_literal: true

require 'bundler/setup'
require 'kickserv'
require 'vcr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def source(file_name)
  path = File.expand_path('fixtures', __dir__)
  File.join(path, file_name)
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :faraday
end

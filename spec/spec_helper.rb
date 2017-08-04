require "bundler/setup"
require "kickserv"
require 'vcr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.extend VCR::RSpec::Macros
end

def source(file_name)
  path = File.expand_path('../fixtures', __FILE__)
  File.join(path, file_name)
end

VCR.configure do |config|
  config.cassette_library_dir     = 'spec/fixtures'
  config.stub_with                  :faraday
end

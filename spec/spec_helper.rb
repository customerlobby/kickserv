require "bundler/setup"
require "kickserv"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def source(file_name)
  path = File.expand_path('../fixtures', __FILE__)
  File.join(path, file_name)
end


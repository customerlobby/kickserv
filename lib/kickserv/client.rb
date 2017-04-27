module Kickserv
  # Wrapper for the Kickserv REST API.
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Kickserv::Client::Customers
    include Kickserv::Client::Jobs
  end
end

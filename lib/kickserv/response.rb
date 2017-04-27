module Kickserv
  module Response
    def self.create(response_hash)
      data = response_hash.data.dup rescue response_hash
      data.extend(self)
      return data
    end

    attr_reader :pagination
    attr_reader :meta
  end
end

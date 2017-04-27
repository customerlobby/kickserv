require "spec_helper"

RSpec.describe Kickserv do
  it "has a version number" do
    expect(Kickserv::VERSION).not_to be nil
  end

  it "should init params" do
    client = Kickserv::Client.new(api_key: 'key', subdomain: 'subdomain')
    expect(client.api_key).to eq('key')
    expect(client.subdomain).to eq('subdomain')
  end
end

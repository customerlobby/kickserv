require 'spec_helper'

RSpec.describe Kickserv::Client do
  it 'should connect using the configured endpoint and api version' do
    client = Kickserv::Client.new(subdomain: 'sub', api_version: '/v2')
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq("https://sub.#{client.endpoint}/v2/")
  end
end

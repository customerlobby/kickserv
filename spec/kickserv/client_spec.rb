require 'spec_helper'

RSpec.describe Kickserv::Client do
  it 'should connect using the configured endpoint and api version' do
    client = Kickserv::Client.new(subdomain: 'sub', api_version: '/v2')
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq("https://sub.#{client.endpoint}/v2/")
  end

  it 'check authorization error' do
    client = Kickserv.client(api_key:"0ed73ed5e0e176336b291f29da3f53517d38b", subdomain:"daffyducts")
    expect(client).to receive(:get).with('jobs.xml', page: 2).and_return("xml")
    expect { raise 'Invalid credentials.' }.to raise_error
    client.jobs(page: 2)
  end
end
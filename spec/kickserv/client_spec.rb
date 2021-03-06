# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kickserv::Client do
  # Test case for checking connection.
  it 'should connect using the configured endpoint and api version' do
    client = Kickserv::Client.new(
      api_key: '98e181fa0ce87977832502ffb4313c8497aca96c',
      account_slug: 'suffolkplumbing',
      api_version: '/v2'
    )
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq("https://#{client.endpoint}/v2/suffolkplumbing/")
  end

  # Test authorization for Kickserv.
  # Test case record the http response in
  # get_auth_error.yml file for offline mode.
  # This test case call http api.
  # Validate fields present in response.
  it 'check authorization error' do
    VCR.use_cassette('get_auth_error') do
      client = Kickserv.client(api_key: 'API_KEY', account_slug: 'daffyducts')
      expect { client.jobs { raise } }.to raise_error('Invalid credentials.')
    end
  end
end

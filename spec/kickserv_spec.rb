# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kickserv do
  it 'has a version number' do
    expect(Kickserv::VERSION).not_to be nil
  end

  it 'should init params' do
    client = Kickserv::Client.new(api_key: 'key', account_slug: 'account_slug')
    expect(client.api_key).to eq('key')
    expect(client.account_slug).to eq('account_slug')
  end
end

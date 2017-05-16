require 'spec_helper'

RSpec.describe Kickserv::Client::Customers do
  it 'should get customers' do
    client = Kickserv::Client.new
    expect(client).to receive(:get).with('customers.xml', page: 2).and_return("xml")
    reader = double("reader")
    expect(Kickserv::XmlReader).to receive(:new).with("xml").and_return(reader)
    expect(reader).to receive(:customers)
    client.customers(page: 2)
  end
end

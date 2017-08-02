require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @client = Kickserv::Client.new
    @reader = double("reader")
  end
end

# Test case to get jobs with page
RSpec.describe Kickserv::Models::Customer do
  it 'should get customer' do
    expect(@client).to receive(:get).with('customers.xml', page: 2).and_return("xml")
    expect(Kickserv::CustomerXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers(page: 2)
  end
end

# Test case to get customer without filter.
RSpec.describe Kickserv::Models::Customer do
  it 'should get customer without filter' do
    expect(@client).to receive(:get).with('customers.xml', {}).and_return("xml")
    expect(Kickserv::CustomerXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers
  end
end

#Test case to filter customer
RSpec.describe Kickserv::Models::Customer do
  it 'should check customer with filter' do
    expect(@client).to receive(:get).with('customers.xml', service_zip_code: 55555).and_return("xml")
    expect(Kickserv::CustomerXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers(service_zip_code: 55555)
  end
end

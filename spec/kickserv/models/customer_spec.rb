require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @client = Kickserv::Client.new
    @reader = double("reader")
  end
end

RSpec.describe Kickserv::Models::Customer do
  # Test case to get jobs with page
  it 'should get customer' do
    expect(@client).to receive(:get).with('customers.xml', page: 2).and_return("xml")
    expect(Kickserv::CustomerXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers(page: 2)
  end

  # Test case to get customer without filter.
  it 'should get customer without filter' do
    expect(@client).to receive(:get).with('customers.xml', {}).and_return("xml")
    expect(Kickserv::CustomerXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers
  end

  #Test case to filter customer
  it 'should check customer with filter' do
    expect(@client).to receive(:get).with('customers.xml', service_zip_code: 55555).and_return("xml")
    expect(Kickserv::CustomerXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers(service_zip_code: 55555)
  end

  # Test jobs without filter from Kickserv data
  # Test case record the http response in
  # get_all_customers_kickserv.yml file for offline mode.
  # This test case call http api.
  # Validate the mandatory fields not nil against response.
  it 'should get valid customers data from Kickserv API' do
    VCR.use_cassette("get_all_customers_kickserv") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      jobs = client.customers
      if jobs.size > 0
        job = jobs[0]
        expect(job['id']).not_to eq(nil)
        expect(job['name']).not_to eq(nil)
        expect(job['billing-address']).not_to eq(nil)
        expect(job['billing-city']).not_to eq(nil)
        expect(job['service-address']).not_to eq(nil)
        expect(job['service-city']).not_to eq(nil)
      end
    end
  end

  # Test customers filter service_zip_code from Kickserv data.
  # Test case record the http response in
  # get_all_customers_kickserv_with_filter_service_zip_code.yml file for offline mode.
  # This test case call http api.
  # Filter the records based on filter like service_zip_code.
  # Validate the each records against filter value.
  it 'should get valid customers data from Kickserv API with filter service_zip_code' do
    VCR.use_cassette("get_all_customers_kickserv_with_filter_service_zip_code") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      jobs = client.customers(service_zip_code: '30102')
      jobs.each do |job|
        expect(job['service-zip-code']).to eq('30102')
      end
    end
  end
end

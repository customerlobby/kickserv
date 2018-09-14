# frozen_string_literal: true

require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @client = Kickserv::Client.new
    @reader = double('reader')
  end
end

RSpec.describe Kickserv::Models::Customer do
  # Test case to get customer without filter.
  it 'should get customer without filter' do
    expect(@client).to receive(:get).with(path: 'customers.xml', params: {}).and_return('xml')
    expect(Kickserv::CustomerXmlReader).to receive(:new).with('xml').and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers
  end

  # Test case to filter customer
  it 'should check customer with filter' do
    expect(@client).to receive(:get).with(path: 'customers.xml', params: { service_zip_code: 55_555 }).and_return('xml')
    expect(Kickserv::CustomerXmlReader).to receive(:new).with('xml').and_return(@reader)
    expect(@reader).to receive(:customers)
    @client.customers(service_zip_code: 55_555)
  end

  # Test case to filter with customer-number.
  it 'should get customer with filter customer_number' do
    customer_number = 2
    expect(@client).to receive(:get).with(url: Kickserv.get_url + 'customers/', path: "#{customer_number}.xml").and_return('xml')
    expect(Kickserv::CustomerXmlReader).to receive(:new).with('xml').and_return(@reader)
    expect(@reader).to receive(:customer)
    @client.customer(2)
  end

  # Test jobs without filter from Kickserv data
  # Test case record the http response in
  # get_all_customers_kickserv.yml file for offline mode.
  # This test case call http api.
  # Validate the mandatory fields not nil against response.
  it 'should get valid customers data from Kickserv API' do
    VCR.use_cassette('get_all_customers_kickserv') do
      client = Kickserv::Client.new(api_key: '98e181fa0ce87977832502ffb4313c8497aca96c', account_slug: 'suffolkplumbing')
      jobs = client.customers
      unless jobs.empty?
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
    VCR.use_cassette('get_all_customers_kickserv_with_filter_service_zip_code') do
      client = Kickserv::Client.new(api_key: '98e181fa0ce87977832502ffb4313c8497aca96c', account_slug: 'suffolkplumbing')
      jobs = client.customers(service_zip_code: '30102')
      jobs.each do |job|
        expect(job['service-zip-code']).to eq('30102')
      end
    end
  end

  # Test customers filter customer_number from Kickserv data.
  # Test case record the http response in
  # get_customer_kickserv_with_customer_number.yml file for offline mode.
  # This test case call http api.
  # Filter the records based on filter like service_zip_code.
  # Validate the each records against filter value.
  it 'should get valid customers data from Kickserv API with filter customer_number' do
    VCR.use_cassette('get_customer_kickserv_with_customer_number') do
      client = Kickserv::Client.new(api_key: '98e181fa0ce87977832502ffb4313c8497aca96c', account_slug: 'suffolkplumbing')
      jobs = client.customer(2)
      expect(jobs.key?('customer-number')).to eq true
      expect(jobs['customer-number']).to eq('2')
    end
  end

  # Test customers  with invalid customer number from Kickserv data.
  # Test case record the http response in
  # get_customer_kickserv_with_customer_number_invalid.yml file for offline mode.
  # This test case call http api.
  # Check the response against the StandardError.
  it 'should get valid customers data from Kickserv API with filter invalid_customer_number' do
    VCR.use_cassette('get_customer_kickserv_with_customer_number_invalid') do
      client = Kickserv::Client.new(api_key: '98e181fa0ce87977832502ffb4313c8497aca96c', account_slug: 'suffolkplumbing')
      expect { client.customer(2_000_000) { raise } }.to raise_error(StandardError)
    end
  end
end

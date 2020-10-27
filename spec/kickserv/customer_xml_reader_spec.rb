# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.configure do |config|
  config.before(:each) do
    @customers = Kickserv::CustomerXmlReader.new(File.read(source('customers.xml'))).customers
  end
end

RSpec.describe Kickserv::CustomerXmlReader do
  it 'should parse customers' do
    aggregate_failures do
      expect(@customers.size).to eq(2)
      expect(@customers[0]['id']).to eq('1614793')
      expect(@customers[0]['name']).to eq('Adrienne Smith')
      expect(@customers[0]['first-name']).to eq('Adrienne')
      expect(@customers[0]['last-name']).to eq('Smith')
      expect(@customers[0]['email']).to eq('asmith221@gmail.com')
      expect(@customers[0]['phone']).to eq('(404) 413-3294')
      expect(@customers[0]['email-address']).to eq('asmith221@gmail.com')
    end
  end

  # Total number of keys in customer xml.
  it 'should check customer object of type xml' do
    xml_file = File.read(source('customers.xml'))
    doc = Nokogiri::XML.parse(xml_file)
    expect(doc.class).to eq(Nokogiri::XML::Document)
  end

  # Total number of keys in customer xml.
  it 'should check customer total number of attributes' do
    expect(@customers[0].keys.length).to eq(37)
  end

  # Test case for validate xml fields
  it 'should validate fields for customer xml' do
    key_hash = %w[id name first-name last-name email phone alt-phone-number
                  alt-phone mobile billing-address billing-address-2
                  billing-city billing-state billing-country
                  billing-zip-code service-address service-address-2
                  service-city service-state service-country
                  service-zip-code which-billing-address is-active
                  company company-name customer-type-ref-full-name
                  terms-ref-full-name sales-rep-ref-full-name
                  balance total-balance customer-type-id
                  send-reminders notification-email-address
                  notify-via-email send-notifications customer-number
                  email-address]
    expect(@customers[0].keys).to contain_exactly(*key_hash)
  end
end

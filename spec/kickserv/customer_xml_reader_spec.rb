require "spec_helper"
require 'nokogiri'

RSpec.configure do |config|
  config.before(:each) do
    @customers = Kickserv::CustomerXmlReader.new(File.read(source("customers.xml"))).customers
  end
end

RSpec.describe Kickserv::CustomerXmlReader do
  it "should parse customers" do
    expect(@customers.size).to eq(2)
    expect(@customers[0]['id']).to eq('1614793')
    expect(@customers[0]['name']).to eq('Adrienne Smith')
    expect(@customers[0]['first-name']).to eq('Adrienne')
    expect(@customers[0]['last-name']).to eq('Smith')
    expect(@customers[0]['email']).to eq('asmith221@gmail.com')
    expect(@customers[0]['phone']).to eq('(404) 413-3294')
    expect(@customers[0]['mobile']).to eq('123-456')
    expect(@customers[0]['alt-phone']).to eq('456-789')
    expect(@customers[0]['service-address']).to eq("Adrienne Smith\n1972 Wright's Way")
    expect(@customers[0]['service-address-2']).to eq('Room.1')
    expect(@customers[0]['service-city']).to eq('Jonesboro')
    expect(@customers[0]['service-state']).to eq('GA')
    expect(@customers[0]['service-zip-code']).to eq('30236')
    expect(@customers[0]['is-active']).to eq('true')
    expect(@customers[0]['company']).to eq('false')
    expect(@customers[0]['company-name']).to eq('not company')
    expect(@customers[0]["billing-address"]).to eq("Adrienne Smith\n1972 Wright's Way")
    expect(@customers[0]["billing-city"]).to eq("Jonesboro")
    expect(@customers[0]["billing-state"]).to eq("GA")
    expect(@customers[0]["billing-zip-code"]).to eq("30236")
    expect(@customers[0]["which-billing-address"]).to eq("service")
    expect(@customers[0]["customer-type-ref-full-name"]).to eq("Internet:Spotrunner Web")
    expect(@customers[0]["terms-ref-full-name"]).to eq("Due on receipt")
    expect(@customers[0]["sales-rep-ref-full-name"]).to eq("JT")
    expect(@customers[0]["balance"]).to eq("0.0")
    expect(@customers[0]["total-balance"]).to eq("0.0")
    expect(@customers[0]["send-reminders"]).to eq("true")
    expect(@customers[0]["notify-via-email"]).to eq("true")
    expect(@customers[0]["send-notifications"]).to eq("true")
  end

  # Total number of keys in customer xml.
  it "should check customer object of type xml" do
    xml_file = File.read(source("customers.xml"))
    doc = Nokogiri::XML.parse(xml_file)
    expect(doc.class).to eq(Nokogiri::XML::Document)
  end

  # Total number of keys in customer xml.
  it "should check customer total number of attributes" do
    expect(@customers[0].keys.length).to eq(35)
  end

  # Test case for validate xml fields
  it "should validate fields for customer xml" do
    key_hash = ['id', 'name', 'first-name', 'last-name', 'email', 'phone',
                'alt-phone-number', 'alt-phone', 'mobile',
                'billing-address', 'billing-address-2',
                'billing-city', 'billing-state', 'billing-country',
                'billing-zip-code', 'service-address', 'service-address-2',
                'service-city', 'service-state', 'service-country',
                'service-zip-code', 'which-billing-address', 'is-active',
                'company', 'company-name', 'customer-type-ref-full-name',
                'terms-ref-full-name', 'sales-rep-ref-full-name', 'balance',
                'total-balance', 'customer-type-id',
                'send-reminders', 'notification-email-address',
                'notify-via-email', 'send-notifications']
    expect(@customers[0].keys).to contain_exactly(*key_hash)
  end
end


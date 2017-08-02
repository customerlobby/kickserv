require "spec_helper"

RSpec.describe Kickserv::CustomerXmlReader do
  it "should parse customers" do
    customers =  Kickserv::CustomerXmlReader.new(File.read(source("customers.xml"))).customers
    expect(customers.size).to eq(2)
    expect(customers[0]['id']).to eq('1614793')
    expect(customers[0]['name']).to eq('Adrienne Smith')
    expect(customers[0]['first-name']).to eq('Adrienne')
    expect(customers[0]['last-name']).to eq('Smith')
    expect(customers[0]['email']).to eq('asmith221@gmail.com')
    expect(customers[0]['phone']).to eq('(404) 413-3294')
    expect(customers[0]['mobile']).to eq('123-456')
    expect(customers[0]['alt-phone']).to eq('456-789')
    expect(customers[0]['service-address']).to eq("Adrienne Smith\n1972 Wright's Way")
    expect(customers[0]['service-address-2']).to eq('Room.1')
    expect(customers[0]['service-city']).to eq('Jonesboro')
    expect(customers[0]['service-state']).to eq('GA')
    expect(customers[0]['service-zip-code']).to eq('30236')
    expect(customers[0]['is-active']).to eq('true')
    expect(customers[0]['company']).to eq('false')
    expect(customers[0]['company-name']).to eq('not company')
  end
end

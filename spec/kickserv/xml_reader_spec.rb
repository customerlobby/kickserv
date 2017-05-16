require "spec_helper"

RSpec.describe Kickserv::XmlReader do
  it "should parse customers" do
    customers =  Kickserv::XmlReader.new(File.read(source("customers.xml"))).customers
    expect(customers.size).to eq(2)
    expect(customers[0][:external_id]).to eq('1614793')
    expect(customers[0][:name]).to eq('Adrienne Smith')
    expect(customers[0][:first_name]).to eq('Adrienne')
    expect(customers[0][:last_name]).to eq('Smith')
    expect(customers[0][:email]).to eq('asmith221@gmail.com')
    expect(customers[0][:phone]).to eq('(404) 413-3294')
    expect(customers[0][:mobile_phone]).to eq('123-456')
    expect(customers[0][:alt_phone]).to eq('456-789')
    expect(customers[0][:address1]).to eq("Adrienne Smith\n1972 Wright's Way")
    expect(customers[0][:address2]).to eq('Room.1')
    expect(customers[0][:city]).to eq('Jonesboro')
    expect(customers[0][:state]).to eq('GA')
    expect(customers[0][:zip]).to eq('30236')
    expect(customers[0][:is_active]).to eq('true')
    expect(customers[0][:is_company]).to eq('false')
    expect(customers[0][:company_name]).to eq('not company')
  end

  it "should parse jobs" do
    jobs =  Kickserv::XmlReader.new(File.read(source("jobs.xml"))).jobs
    expect(jobs.size).to eq(2)
    expect(jobs[0][:external_id]).to eq('16168073')
    expect(jobs[0][:external_customer_id]).to eq('2157206')
    expect(jobs[0][:amount]).to eq('250.0')
    expect(jobs[0][:subtotal]).to eq('275.0')
    expect(jobs[0][:balance]).to eq('250.0')
    expect(jobs[0][:transacted_at]).to eq('2017-04-27T10:05:33-04:00')
    expect(jobs[0][:due_date]).to eq('2022-02-06T12:00:00-05:00')
  end
end

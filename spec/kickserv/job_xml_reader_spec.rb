require "spec_helper"
require 'nokogiri'

RSpec.configure do |config|
  config.before(:each) do
    @jobs = Kickserv::JobXmlReader.new(File.read(source("jobs.xml"))).jobs
  end
end

RSpec.describe Kickserv::JobXmlReader do
  it "should parse jobs" do
    expect(@jobs.size).to eq(2)
    expect(@jobs[0]['id']).to eq('16168073')
    expect(@jobs[0]['customer-id']).to eq('2157206')
    expect(@jobs[0]['total']).to eq('250.0')
    expect(@jobs[0]['subtotal']).to eq('275.0')
    expect(@jobs[0]['balance-remaining']).to eq('250.0')
    expect(@jobs[0]["name"]).to eq("Dryer Vent Cleaning")
    expect(@jobs[0]["job-type-id"]).to eq("14759")
    expect(@jobs[0]["status"]).to eq("scheduled")
  end

  # Total number of keys in job xml.
  it "should check job total number of attributes" do
    expect(@jobs[0].keys.length).to eq(27)
  end

  # Total number of keys in customer xml.
  it "should check job object of type xml" do
    xml_file = File.read(source("jobs.xml"))
    doc = Nokogiri::XML.parse(xml_file)
    expect(doc.class).to eq(Nokogiri::XML::Document)
  end

  # Test case for validate xml fields
  it "should validate fields for jobs xml" do
    key_hash = %w(id customer-id total subtotal balance-remaining
                        created-at scheduled-on started-on completed-on name txn-id
                        recurring-job-id job-type-id job-status-id duration invoice-terms
                        invoice-notes estimate-terms estimate-notes description
                        status invoice-status invoice-date invoice-paid-on
                        notification-sent total-expenses job-number)
    expect(@jobs[0].keys).to contain_exactly(*key_hash)
  end
end
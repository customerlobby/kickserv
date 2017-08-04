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
    expect(@jobs[0].keys.length).to eq(18)
  end

  # Total number of keys in customer xml.
  it "should check job object of type xml" do
    xml_file = File.read(source("jobs.xml"))
    doc = Nokogiri::XML.parse(xml_file)
    expect(doc.class).to eq(Nokogiri::XML::Document)
  end

  # Test case for validate xml fields
  it "should validate fields for jobs xml" do
    key_hash = ['id', 'customer-id', 'total', 'subtotal', 'balance-remaining',
                'created-at', 'scheduled-on', 'name', 'recurring-job-id', 'job-type-id',
                'invoice-terms', 'invoice-notes', 'estimate-terms',
                'description', 'status', 'invoice-status',
                'notification-sent', 'job-number']
    expect(@jobs[0].keys).to contain_exactly(*key_hash)
  end
end
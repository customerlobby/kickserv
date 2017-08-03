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
    expect(@jobs[0]['created-at']).to eq('2017-04-27T10:05:33-04:00')
    expect(@jobs[0]['scheduled-on']).to eq('2022-02-06T12:00:00-05:00')
    expect(@jobs[0]["name"]).to eq("Dryer Vent Cleaning")
    expect(@jobs[0]["recurring-job-id"]).to eq("7102958")
    expect(@jobs[0]["job-type-id"]).to eq("14759")
    expect(@jobs[0]["invoice-terms"]).to eq("Due upon receipt\n\nUpon cleaning dryer we got a burning smell coming from dryer. Might be advised to have an appliance man come take a look at dryer to make sure the element is not going out in it.\n\n\nPlease make arranggement to pay invoice. \n\nThank You\n")
    expect(@jobs[0]["invoice-notes"]).to eq("There is a 1.5% monthly fee for past due invoices. Thank you for your business.")
    expect(@jobs[0]["estimate-terms"]).to eq("Bid price good for 7 days.")
    expect(@jobs[0]["description"]).to eq("$250,Stockbridge,DVC.")
    expect(@jobs[0]["status"]).to eq("scheduled")
    expect(@jobs[0]["invoice-status"]).to eq("unpaid")
    expect(@jobs[0]["notification-sent"]).to eq("false")
  end

  # Total number of keys in job xml.
  it "should check job total number of attributes" do
    expect(@jobs[0].keys.length).to eq(26)
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
                'created-at', 'scheduled-on', 'started-on', 'completed-on',
                'name', 'txn-id', 'recurring-job-id', 'job-type-id', 'job-status-id',
                'duration', 'invoice-terms', 'invoice-notes', 'estimate-terms', 'estimate-notes',
                'description', 'status', 'invoice-status', 'invoice-date', 'invoice-paid-on',
                'notification-sent', 'total-expenses']
    expect(@jobs[0].keys).to contain_exactly(*key_hash)
  end
end
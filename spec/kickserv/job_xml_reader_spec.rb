require "spec_helper"

RSpec.describe Kickserv::JobXmlReader do
  it "should parse jobs" do
    jobs = Kickserv::JobXmlReader.new(File.read(source("jobs.xml"))).jobs
    expect(jobs.size).to eq(2)
    expect(jobs[0]['id']).to eq('16168073')
    expect(jobs[0]['customer-id']).to eq('2157206')
    expect(jobs[0]['total']).to eq('250.0')
    expect(jobs[0]['subtotal']).to eq('275.0')
    expect(jobs[0]['balance-remaining']).to eq('250.0')
    expect(jobs[0]['created-at']).to eq('2017-04-27T10:05:33-04:00')
    expect(jobs[0]['scheduled-on']).to eq('2022-02-06T12:00:00-05:00')
  end
end
require 'spec_helper'

RSpec.describe Kickserv::Model::Job do
  it 'should get jobs' do
    client = Kickserv::Client.new
    expect(client).to receive(:get).with('jobs.xml', page: 2).and_return("xml")
    reader = double("reader")
    expect(Kickserv::XmlReader).to receive(:new).with("xml").and_return(reader)
    expect(reader).to receive(:jobs)
    client.jobs(page: 2)
  end
end

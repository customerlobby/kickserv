require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @client = Kickserv::Client.new
    @reader = double("reader")
  end
end

RSpec.describe Kickserv::Models::Job do
  # Test case to get jobs with page.
  it 'should get jobs' do
    expect(@client).to receive(:get).with('jobs.xml', page: 2).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(page: 2)
  end

  # Test case to get jobs without filter.
  it 'should check jobs without filter' do
    expect(@client).to receive(:get).with('jobs.xml', {}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs
  end

  # Test case to filter job with schedule day
  it 'should check jobs with filter' do
    expect(@client).to receive(:get).with('jobs.xml', scheduled: 'today').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(scheduled: 'today')
  end

  # Test case to filter with state of job
  it 'should check jobs with state' do
    expect(@client).to receive(:get).with('jobs.xml', state: 'uncompleted').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(state: 'uncompleted')
  end

  # Test case to filter by employee
  it 'should check jobs with employee number' do
    expect(@client).to receive(:get).with('jobs.xml', employee_number: 123).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(employee_number: 123)
  end

  # Test case to filter by category
  it 'should check jobs with category' do
    expect(@client).to receive(:get).with('jobs.xml', job_type_id: 123).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(job_type_id: 123)
  end

  # Test case to filter by job status
  it 'should check jobs with job status' do
    expect(@client).to receive(:get).with('jobs.xml', job_status_id: 123).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(job_status_id: 123)
  end

  # Test case with relational database.
  it 'should check jobs relational data' do
    expect(@client).to receive(:get).with('jobs.xml', include: 'customer,job_charges').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(include: 'customer,job_charges')
  end

  # Test case to filter with only.
  it 'should check jobs with only parameter' do
    expect(@client).to receive(:get).with('jobs.xml', only: 'job_number,name').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(only: 'job_number,name')
  end

  # Test customers without filter from Kickserv data
  it 'should get valid job data from Kickserv API' do
    VCR.use_cassette("get_all_jobs_kickserv") do
      client =  Kickserv::Client.new(api_key: 'API_TOKEN', subdomain: 'daffyducts')
      jobs = client.jobs
      expect(jobs.class).to eq(Array)
      if jobs.size > 0
        job = jobs[0]
        expect(job['id']).not_to eq(nil)
      end
    end
  end
end



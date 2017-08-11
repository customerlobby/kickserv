require 'spec_helper'
require 'date'


RSpec.configure do |config|
  config.before(:each) do
    @client = Kickserv::Client.new
    @reader = double("reader")
  end
end

RSpec.describe Kickserv::Models::Job do
  # Test case to get jobs without filter.
  it 'should check jobs without filter' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs
  end

  # Test case to filter job with schedule day
  it 'should check jobs with filter' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:scheduled=> 'today'}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(scheduled: 'today')
  end

  # Test case to filter with state of job
  it 'should check jobs with state' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:state=> 'uncompleted'}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(state: 'uncompleted')
  end

  # Test case to filter by employee
  it 'should check jobs with employee number' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:employee_number=> 123}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(employee_number: 123)
  end

  # Test case to filter by category
  it 'should check jobs with category' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:job_type_id=> 123}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(job_type_id: 123)
  end

  # Test case to filter by job status
  it 'should check jobs with job status' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:job_status_id => 123}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(job_status_id: 123)
  end

  # Test case with relational database.
  it 'should check jobs relational data' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:include => 'customer,job_charges'}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(include: 'customer,job_charges')
  end

  # Test case to filter with only.
  it 'should check jobs with only parameter' do
    expect(@client).to receive(:get).with(path:'jobs.xml', params:{:only => 'job_number,name'}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(only: 'job_number,name')
  end

  # Test case to filter job with job-number.
  it 'should get jobs with filter job_number' do
    job_number = 30
    expect(@client).to receive(:get).with({:url=> Kickserv.get_url + 'jobs/', :path=>"#{job_number}.xml"}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.job(30)
  end

  # Test jobs without filter from Kickserv data.
  # Test case record the http response in
  # get_all_jobs_kickserv.yml for offline mode
  # This test case call the http api.
  # Validate the mandatory fields not nil against response.
  it 'should get valid job data from Kickserv API' do
    VCR.use_cassette("get_all_jobs_kickserv") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      jobs = client.jobs
      expect(jobs.class).to eq(Array)
      if jobs.size > 0
        job = jobs[0]
        expect(job['id']).not_to eq(nil)
        expect(job['job-number']).not_to eq(nil)
        expect(job['job-type-id']).not_to eq(nil)
        expect(job['name']).not_to eq(nil)
        expect(job['status']).not_to eq(nil)
      end
    end
  end

  # Test jobs filter as schedule:today from Kickserv data.
  # Test case record the http response in
  # get_all_jobs_kickserv_with_filter_scheduled_on.yml file for offline mode.
  # This test call http api.
  # Filter the records based on schedule:today.
  # Validate each record with current date.
  it 'should get valid job data from Kickserv API with filter schedule' do
    VCR.use_cassette("get_all_jobs_kickserv_with_filter_scheduled_on") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      jobs = client.jobs(scheduled: 'today')
      jobs.each do |job|
        schedule_date = DateTime.parse(job['scheduled-on']).to_date
        current_date = Date::strptime('2017-08-04', "%Y-%m-%d")
        expect(schedule_date).to eq(current_date)
      end
    end
  end

  # Test jobs with filter as only from Kickserv data.
  # Test case record the http response in
  # get_all_jobs_kickserv_with_filter_only.yml file for offline mode.
  # This test case call http api.
  # Filter the records based on only filter tag.
  # Validate fields present in response.
  it 'should get valid job data from Kickserv API with filter only' do
    VCR.use_cassette("get_all_jobs_kickserv_with_filter_only") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      jobs = client.jobs(only: 'job_number,id,customer_id,name,status')
      jobs.each do |job|
        expect(job.has_key?("id")).to eq true
        expect(job.has_key?("customer-id")).to eq true
        expect(job.has_key?("name")).to eq true
        expect(job.has_key?("status")).to eq true
        expect(job.has_key?("job-number")).to eq true
        expect(job.keys.length).to eq(5)
      end
    end
  end

  # Test jobs with filter as job-number from Kickserv data.
  # Test case record the http response in
  # get_jobs_with_job_number.yml file for offline mode.
  # This test case call http api.
  # Validate fields present in response.
  it 'should get valid job data from Kickserv API with filter job_number' do
    VCR.use_cassette("get_jobs_with_job_number") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      jobs = client.job(3)
      expect(jobs.has_key?("job-number")).to eq true
      expect(jobs['job-number']).to eq("3")
    end
  end

  # Test jobs with invalid job number from Kickserv data.
  # Test case record the http response in
  # get_customer_kickserv_with_job_number_invalid.yml file for offline mode.
  # This test case call http api.
  # Check the response against the StandardError.
  it 'should get valid customers data from Kickserv API with filter invalid_job_number' do
    VCR.use_cassette("get_customer_kickserv_with_job_number_invalid") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      expect {client.job(2000000){raise}}.to raise_error(StandardError)
    end
  end

  # Test jobs with  filter as state from Kickserv data.
  # Test case use get_all_jobs_kickserv_with_filter_state.yml to record http response.
  # This test case call http api.
  # Filter the records based on state.
  # Validate the response against state field.
  # it 'should get valid job data from Kickserv API with filter state' do
  #   VCR.use_cassette("get_all_jobs_kickserv_with_filter_state") do
  #     client =  Kickserv::Client.new(api_key: '0ed73ed5e0e176336b291f29da3f53517d38bf7b', subdomain: 'daffyducts')
  #     jobs = client.jobs(state: 'completed')
  #     jobs.each do |job|
  #       expect(jobs.has_key?("state")).to eq true
  #       expect(job['state']).to eq('completed')
  #     end
  #   end
  # end

  # # Test jobs with filter with combination of page and scheduled from  kickserv data
  # # Test case use get_all_jobs_kickserv_with_filter_combination.yml to record http response.
  # # This test case call http api.
  # # Filter the records based on combinations like page, scheduled and state.
  # # Validate the response.
  # it 'should get valid job data from Kickserv API with filter combination' do
  #   current_date = DateTime.now.strftime("%Y-%m-%d").to_date
  #   VCR.use_cassette("get_all_jobs_kickserv_with_filter_combination") do
  #     client =  Kickserv::Client.new(api_key: '0ed73ed5e0e176336b291f29da3f53517d38bf7b', subdomain: 'daffyducts')
  #     jobs = client.jobs(page: 1, scheduled: 'today', state:'uncompleted')
  #     jobs.each do |job|
  #       schedule_date = DateTime.parse(job['scheduled-on']).to_date
  #       #expect(job['state']).to eq('uncompleted')
  #       expect(schedule_date).to eq(current_date)
  #     end
  #   end
  # end
end



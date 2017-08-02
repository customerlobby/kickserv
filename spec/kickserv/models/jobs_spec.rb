require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    @client = Kickserv::Client.new
    @reader = double("reader")
  end
end

# Test case to get jobs with page.
RSpec.describe Kickserv::Models::Job do
  it 'should get jobs' do
    expect(@client).to receive(:get).with('jobs.xml', page: 2).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(page: 2)
  end
end

# Test case to get jobs without filter.
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs without filter' do
    expect(@client).to receive(:get).with('jobs.xml', {}).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs
  end
end

# Test case to filter job with schedule day
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs with filter' do
    expect(@client).to receive(:get).with('jobs.xml', scheduled: 'today').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(scheduled: 'today')
  end
end

# Test case to filter with state of job
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs with state' do
    expect(@client).to receive(:get).with('jobs.xml', state: 'uncompleted').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(state: 'uncompleted')
  end
end

# Test case to filter by employee
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs with employee number' do
    expect(@client).to receive(:get).with('jobs.xml', employee_number: 123).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(employee_number: 123)
  end
end

# Test case to filter by category
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs with category' do
    expect(@client).to receive(:get).with('jobs.xml', job_type_id: 123).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(job_type_id: 123)
  end
end

# Test case to filter by job status
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs with job status' do
    expect(@client).to receive(:get).with('jobs.xml', job_status_id: 123).and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(job_status_id: 123)
  end
end

# Test case with relational database.
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs relational data' do
    expect(@client).to receive(:get).with('jobs.xml', include: 'customer,job_charges').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(include: 'customer,job_charges')
  end
end

# Test case to filter with only.
RSpec.describe Kickserv::Models::Job do
  it 'should check jobs with only parameter' do
    expect(@client).to receive(:get).with('jobs.xml', only:'job_number,name').and_return("xml")
    expect(Kickserv::JobXmlReader).to receive(:new).with("xml").and_return(@reader)
    expect(@reader).to receive(:jobs)
    @client.jobs(only:'job_number,name')
  end
end



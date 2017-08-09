# Kickserv

A Ruby wrapper for the Kickserv REST API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kickserv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kickserv

## Usage

### Configuration

Before you can make calls to Kickserv you must configure the library with a valid API Token and a valid subdomain.
An employee’s unique API token can be found in the employee management section of your Kickserv account.

There are two ways to configure the  gem. You can pass a hash of configuration options when you create
a client, or you can use a configure block.

```ruby
client = Kickserv.client(api_key: "YOUR_TOKEN_HERE", subdomain: "YOUR_SUBDOMAIN_HERE")
```

```ruby
Kickserv.configure do |config|
  config.api_key = "YOUR_TOKEN_HERE"
  config.subdomain = "YOUR_SUBDOMAIN_HERE"
end

client = Kickserv.client
```

### Get customers

```ruby
client.customers
client.customers(page: 2)
client.customers(service_zip_code: '30102')
client.customers(name: 'Aime Pavao')
client.customers(customer_number: '2')
```

### Get jobs

```ruby
client.jobs
client.jobs(page: 2, only: %w{total subtotal})
client.jobs(scheduled: 'today')
client.jobs(state: 'completed')
client.jobs(job_type_id: 14761)
client.jobs(only: 'job_number,id,customer_id,name,status')
client.jobs(page: 1, scheduled: 'today', state: 'uncompleted')
client.jobs(job_number: '3')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


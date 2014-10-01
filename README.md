# ServicesTestServer

Allows a client to do integration tests against a service with a transaction.
This server starts a DRb that can start/rollback transactions with
ActiveRecord.

## Installation

Add this line to your application's Gemfile:

    gem 'services_test_server'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install services_test_server

## Usage

Configure what port DRb will listen on:

```
ServicesTestServer.control_port = 8001
```

In your `config/environments/test.rb` (or in a test initializer):

```
config.after_initialize do
  ServicesTestServer.start
end
```

If you would like some logging, you can also configure the logger:

```
ServicesTestServer.logger = Rails.logger
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/services_test_server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

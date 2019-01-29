# CDM

A simple wrapper for the ContentDM Api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cdm_rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cdm_rb

## Usage

### Configuration
You'll need to configure the CDM gem to ensure you query the appropriate data. To do so in a rails app, create config/initializers/cdm.rb with :

```ruby
Primo.configure do |config|
  # A server url is required or the applicaiton wil errror out.
  config.server_url     = 'https://my-cdm-server.com'

  # By default enable_loggagle is set to false
  config.enable_loggagle = false
end
```
Now you can access those configuration attributes with `CDM.configuration.max_recs`

### Making Requests

#### Making simple requests
Simple requests are easy:

* Pass a string and you will query titles containing the string

```
CDM.find("otter")
```

### Logging
This gem exposes a loggable interface to responses.  Thus a response will respond to `loggable` and return a hash with state values that may be of use to log.

As a bonus, when we enable this feature using the `enable_loggable` configuration, error messages will contain the loggable values and be formatted as JSON.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cdm_rb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


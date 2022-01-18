# doubleloop-ruby
[![Changelog](https://img.shields.io/badge/DoubleLoop-Changelog-blue)](https://app.doubleloop.app/p/DoubleLoop/changelog-doubleloop-ruby-3)

A gem to interact with [DoubleLoop's API](https://app.doubleloop.app/apidocs/1.0)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doubleloop'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install doubleloop

## Usage

The library needs to be configured with your project's API token. Set
`DoubleLoop.api_token` to its value:

```ruby
# Set the API token (available at https://app.doubleloop.app/organizations/settings/integrations)
DoubleLoop.api_token = "my-secret-token"

# create a Metric Data Point
result = DoubleLoop::Metric.create(
  name: "My Metric",
  date: Datetime.parse("2021/11/25 14:22:30"),
  value: 1_000,
  metric_type: DoubleLoop::Metric::COUNTS
)

# get the metric data
result.metric.name # "My Metric"

# create an Event
result = DoubleLoop::Event.create(
  headline: "1.0 Release",
  happened_at: DateTime.parse('2022-01-01 11:45:31'),
  summary: "Today we finally went live with our 1.0!",
  importance: DoubleLoop::Event::MAJOR_IMPORTANCE,
  impact: DoubleLoop::Event::POSITIVE_IMPACT,
  labels: %w[foo bar baz]
)

# get the metric data
result.entity.headline # "My Metric"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, 
update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a 
git tag for the version, push git commits and the created tag, and push the `.gem` file 
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/doubleloopapp/doubleloop-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

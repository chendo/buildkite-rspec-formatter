# Buildkite RSpec Formatter

This formatter breaks up your test suite into sections and will collapse unnecessary output and only show failures, making it easier to understand a build failure.

Supports [capybara-inline-screenshot](https://github.com/buildkite/capybara-inline-screenshot).

![Screenshot](https://cloud.githubusercontent.com/assets/2661/20782420/bee0d20e-b7df-11e6-873e-a149ca66e77d.png)

This formatter makes it

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'buildkite-rspec-formatter', github: 'chendo/buildkite-rspec-formatter', require: false
```

Modify your `spec_helper.rb`

```ruby
require "buildkite/rspec/formatter"

RSpec.configure do |config|
  # Use the Buildkite formatter when running on Buildkite.
  config.formatter = ENV['BUILDKITE'] ? Buildkite::RSpec::Formatter : :documentation
end
```

## Options

The formatter will by default only render sections 2 levels deep. You can override this by setting `BUILDKITE_RSPEC_MAX_DEPTH` to your desired depth.

If you have long integration tests, you may want each scenario to have its own heading. You can do this by setting `BUILDKITE_RSPEC_BREAK_ON_EXAMPLE`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/buildkite-rspec-formatter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


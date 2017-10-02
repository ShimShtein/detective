# Detective

This gem exposes [rubocop](http://rubocop.readthedocs.io) functionality as a REST service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'detective'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install detective

## Usage

You can run it either as a standalone service:
``` sh
bin/detective <additional/cops/glob/pattern1> <additional/cops/glob/pattern2>
```
or add it to an existing rack application:
``` ruby
# in your config.ru file:
require 'detective/web/endpoint'

additional_cops = [
  'additional/cops/glob/pattern1',
  'additional/cops/glob/pattern2'
]

detective = Detective::Web::Endpoint.new
detective.settings.set(:cops_patterns, cops_patterns)

run detective
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shimshtein/detective.


## License

The gem is available as open source under the terms of the [LGPL-3.0 License](https://opensource.org/licenses/LGPL-3.0).

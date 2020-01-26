# DNS::Monitor

The point of this gem is to monitor your hosts for (unwanted) DNS changes. The executable `dns-monitor` file is designed to be run as a CRON job. It takes a return-delimited text file listing domain names, and checks an RDAP database (which you can specify) for JSON entries that match. You will get an error, optionally by GChat, if you encounter a changed entry.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dns-monitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dns-monitor



## Usage

For usage, run `dns-monitor -h`



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dns-monitor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



## Code of Conduct

Everyone interacting in the Dns::Monitor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dns-monitor/blob/master/CODE_OF_CONDUCT.md).

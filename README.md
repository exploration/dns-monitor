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

Since we use them at [EXPLO](https://www.explo.org), we've added flags to send notifications directly via Google Hangouts Chat or via a Mandrill API call. The script will also send updates to STDOUT and STDERR as necessary, so if you don't use either of those services you can pipe output into whichever notification setup you prefer.

Since the script is designed to be run as a CRON job, you can specify with flags where you want to store your `hosts` and database file:

    dns-monitor --check --db_path "/your/db/folder/and_filename.sqlite3" --domains_path "/your/domains/textfile/folder/and_filename.txt"

### Usage with Google Hangouts Chat

To use with Google Hangouts Chat, you'll need to set up a webhook in the appropriate chat room. You'll get a webhook URL which you can send to `dns-monitor` with `-g` or `--gchat` like this:

    dns-monitor --check --gchat YOUR_URL

### Usage with Mandrill

To use with Mandrill, you'll need an API key capable of sending messages, and a recipient email. The 'from' email will automatically be set to `dns-monitor` at your domain, so if you sent `donald@explo.org`, the `FROM` address would be `dns-monitor@explo.org`.

You need to set both flags on the command-line client for Mandrill to be activated, and emails will only be sent if there are changes to the domain list since the previous run:

    dns-monitor --check --mandrill_api "YOURAPIKEY" --mandrill_email "recipient@yourdomain.com"



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on Bitbucket at https://github.com/exploration/dns-monitor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



## Code of Conduct

Everyone interacting in the DNS::Monitor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/exploration/dns-monitor/blob/master/CODE_OF_CONDUCT.md).

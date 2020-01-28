# DNS::Monitor

[![Gem Version](https://badge.fury.io/rb/dns-monitor.svg)](https://badge.fury.io/rb/dns-monitor)

The point of this gem is to monitor your hosts for (unwanted) DNS changes. The executable `dns-monitor` file is designed to be run as a CRON job. It takes a return-delimited text file listing domain names, and checks an RDAP database (which you can specify) for JSON entries that match. You will get an error, optionally by GChat, if you encounter a changed entry.

If you don't think this is something you need, perhaps give [this article](https://krebsonsecurity.com/2019/02/a-deep-dive-on-the-recent-widespread-dns-hijacking-attacks/) a read.



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

For usage, run `dns-monitor -h`.

Since we use them at [EXPLO](https://www.explo.org), we've added flags to send notifications directly via Google Hangouts Chat or via a Mandrill API call. The script will also send updates to STDOUT and STDERR as necessary, so if you don't use either of those services you can pipe output into whichever notification setup you prefer.

### Checking All Hosts

The main mode is `--check` or `-c`, which will check all hosts in your host file (just a return-delimited text file of top-level hostnames) for DNS changes. Changes will be stored in an SQLite3 database and logged. As noted above, you can be optionally alerted by GChat or email, or you can simply pipe output into whichever alert utility you prefer.

### Checking a Specific Domain

You can get all domain history for a specific domain like this:

```bash
dns-monitor --domain DOMAIN
```

You'll get a JSON array of RDAP entries back - every change that's been logged on that domain since you started tracking.

### RDAP Server

DNS::Monitor uses [RDAP](https://www.icann.org/rdap) for checking WHOIS records, because it gives you JSON back! The nice thing about this is that because it's all just JSON + hashes, DNS::Monitor can only display specifically what changed for a domain.

We use and love [Pair Domains](https://pairdomains.com) as our registrar, so we've coded their RDAP server in by default, but if you have a different registrar, you'll want to pass a flag to change that server eg:

```bash
dns-monitor --check --rdap_url https://your-rdap-server.com
```

### File Paths

Since the script is designed to be run as a CRON job, you can specify with flags where you want to store your `hosts.txt` and database (sqlite) file:

```bash
dns-monitor --check --db_path "/your/db/folder/and_filename.sqlite3" --domains_path "/your/domains/textfile/folder/and_filename.txt"
```


### Usage with Google Hangouts Chat

To use with Google Hangouts Chat, you'll need to set up a webhook in the appropriate chat room. You'll get a webhook URL which you can send to `dns-monitor` with `-g` or `--gchat` like this:

```bash
dns-monitor --check --gchat YOUR_WEBHOOK_URL
```

### Usage with Mandrill

To use with Mandrill, you'll need an API key capable of sending messages, and a recipient email. The 'from' email will automatically be set to `dns-monitor` at your domain, so if you sent `donald@explo.org`, the `FROM` address would be `dns-monitor@explo.org`.

You need to set both flags on the command-line client for Mandrill to be activated, and emails will only be sent if there are changes to the domain list since the previous run:

```bash
dns-monitor --check --mandrill_api "YOURAPIKEY" --mandrill_email "recipient@yourdomain.com"
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on Bitbucket at https://github.com/exploration/dns-monitor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



## Code of Conduct

Everyone interacting in the DNS::Monitor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/exploration/dns-monitor/blob/master/CODE_OF_CONDUCT.md).

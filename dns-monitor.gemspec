lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dns/monitor/version"

Gem::Specification.new do |spec|
  spec.name          = "dns-monitor"
  spec.version       = DNS::Monitor::VERSION
  spec.authors       = ["Donald Merand"]
  spec.email         = ["dmerand@explo.org"]

  spec.summary       = %q{Monitor a list of hosts for DNS changes}
  spec.description   = <<~DESCRIPTION
    The point of this gem is to monitor your hosts for (unwanted) DNS changes.
    The `dns-monitor` file is designed to be run as a CRON job. It takes a
    return-delimited text file listing domain names, and checks an RDAP
    database (which you can specify) for JSON entries that match. You will get
    an error, optionally by GChat, if you encounter a changed entry.
  DESCRIPTION
  spec.homepage      = "https://github.com/exploration/dns-monitor"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.12.2"

  spec.add_dependency "sqlite3", "~>1.4.2"
end

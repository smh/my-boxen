# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod name, :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.3.4"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "dnsmasq",    "1.0.0"
github "foreman",    "1.0.0"
github "gcc",        "2.0.1"
github "git",        "1.2.5"
github "go",         "1.0.0"
github "homebrew",   "1.5.1"
github "hub",        "1.0.3"
github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.2"
github "nodejs",     "3.3.0"
github "openssl",    "1.0.0"
github "phantomjs",  "2.0.2"
github "pkgconfig",  "1.0.0"
github "repository", "2.2.0"
github "ruby",       "6.7.2"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.0"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "sysctl",      "1.0.0"
github "pckeyboardhack", "1.0.8", :repo => "smh/puppet-pckeyboardhack"
github "keyremap4macbook", "1.2.1"
github "modern_space_cadet", "1.0.2", :repo => "smh/puppet-modern_space_cadet"
github "better_touch_tools", "1.0.0"
github "osx",         "1.6.0"
github "property_list_key", "0.1.0", :repo => 'glarizza/puppet-property_list_key'
github "slate",       "1.0.0"
github "emacs",       "1.1.0"
github "iterm2",      "1.0.3"
github "zsh",         "1.0.0"
github "autojump",    "1.0.0"
github "tmux",        "1.0.2"
github "wget",        "1.0.0"

github "redis",       "1.0.0"
github "mongodb",     "1.0.4"
github "postgresql",  "2.0.1"

github "heroku",      "2.0.0"
github "java",        "1.1.0"
github "clojure",     "1.2.0"
github "python",      "1.2.1"

github "firefox",     "1.1.3"
github "chrome",      "1.1.1"

github "dropbox",     "1.1.1"

github "intellij",    "1.4.0"

github "onepassword", "1.0.2"
github "alfred",      "1.1.4"
github "skype",       "1.0.4"
github "notational_velocity", "1.1.1"
github "googleearth", "1.0.0"
github "colloquy",    "1.0.0"

github "appcleaner",  "1.0.0"
github "ccleaner",    "1.0.2"
github "daisy_disk",  "1.0.0"
github "istatmenus4", "1.0.1", :repo => "smh/puppet-istatmenus4"

github "virtualbox",  "1.0.5"
github "vagrant",     "3.0.0"

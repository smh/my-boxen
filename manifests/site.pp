require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  include ruby::1_8_7
  include ruby::1_9_2
  include ruby::1_9_3
  include ruby::2_0_0

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

  # additional modules
  #  include pckeyboardhack
  #  include keyremap4macbook
  include emacs
  include slate
  include iterm2::dev
  include zsh
  include autojump
  include tmux
  include wget
  include xquartz

  package { 'mercurial': }
  package { 'vim':
    require         => Package[mercurial],
    install_options => [
      '--with-cscope',
      '--override-system-vim',
      '--enable-pythoninterp'
    ]
  }
  package { 'macvim':
    install_options => [
      '--with-cscope',
    ]
  }

  # additional homebrew packages
  package {
    [
      'ledger',
      'tree',
      'ssh-copy-id',
      'tig',
      'ctags-exuberant',
      'direnv'
    ]:
  }

  include redis
  include mongodb
  include postgresql

  include heroku

  include java
  include clojure
  include python

  include firefox
  include firefox::nightly
  include chrome
  include chrome::dev

  include dropbox
  include better_touch_tools

  class { 'intellij':
    edition => 'ultimate',
    version => '13.0.1'
  }

  include onepassword
  include alfred
  include skype
  include notational_velocity::nvalt
  include googleearth
  include colloquy

  include appcleaner
  include ccleaner
  include daisy_disk
  include istatmenus4

  include virtualbox
  include vagrant
  #vagrant::plugin { 'vagrant-veewee': }

  #vagrant::plugin { 'vagrant-vmware-fusion':
  #    license => 'puppet:///modules/people/joe/licenses/fusion.lic',
  #}

  #vagrant::box { 'squeeze64/vmware_fusion':
  #    source => 'https://s3.amazonaws.com/github-ops/vagrant/squeeze64-6.0.7-vmware_fusion.box'
  #}
}

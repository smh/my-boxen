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
    "${boxen::config::homebrewdir}/bin",
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
  nodejs::version { '0.6': }
  nodejs::version { '0.8': }
  nodejs::version { '0.10': }
  nodejs::version { '0.12': }

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

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
  include brewcask

  package { 'firefox': provider => 'brewcask' }
  package { 'virtualbox': provider => 'brewcask' }
  package { 'vagrant': provider => 'brewcask' }
  package { 'google-chrome': provider => 'brewcask' }
  package { 'iterm2': provider => 'brewcask' }
  package { 'emacs': provider => 'brewcask' }
  package { '1password': provider => 'brewcask' }
  package { 'skype': provider => 'brewcask' }
  package { 'alfred': provider => 'brewcask' }
  package { 'dropbox': provider => 'brewcask' }
  package { 'google-earth': provider => 'brewcask' }
  package { 'colloquy': provider => 'brewcask' }
  package { 'nvalt': provider => 'brewcask' }
  package { 'slate': provider => 'brewcask' }
  package { 'java': provider => 'brewcask' }
  package { 'appcleaner': provider => 'brewcask' }
  package { 'ccleaner': provider => 'brewcask' }

  #include emacs
  #include slate
  #include iterm2::stable
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
      'direnv',
      'git-flow',
      'git-extras',
      'docker',
      'boot2docker',
      'grc'
    ]:
  }

  include heroku

  include clojure
  include python
  include istatmenus4
}

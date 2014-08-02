class people::smh {

  include modern_space_cadet

  include projects::all

  repository { "${::boxen_srcdir}/puppet-seil": source => 'boxen/puppet-seil' }
  repository { "${::boxen_srcdir}/puppet-karabiner": source => 'boxen/puppet-karabiner' }
  repository { "${::boxen_srcdir}/puppet-modern_space_cadet": source => 'boxen/puppet-modern_space_cadet' }

  repository { "/Users/${::boxen_user}/.dotfiles": source => 'smh/dotfiles' }

  file { "/Users/${::boxen_user}/.jshintrc":
    ensure  => 'link',
    target  => "/Users/${::boxen_user}/.dotfiles/jshintrc",
    require => Repository["/Users/${::boxen_user}/.dotfiles"]
  }

  file { "/Users/${::boxen_user}/.vimrc":
    ensure  => 'link',
    target  => "/Users/${::boxen_user}/.dotfiles/vimrc",
    require => Repository["/Users/${::boxen_user}/.dotfiles"]
  }

  file { "/Users/${::boxen_user}/.gvimrc":
    ensure  => 'link',
    target  => "/Users/${::boxen_user}/.dotfiles/gvimrc",
    require => Repository["/Users/${::boxen_user}/.dotfiles"]
  }

  file { "/Users/${::boxen_user}/.zshrc":
    ensure  => 'link',
    target  => "/Users/${::boxen_user}/.dotfiles/zshrc",
    require => Repository["/Users/${::boxen_user}/.dotfiles"]
  }

  repository { "/Users/${::boxen_user}/.boxen_licenses": source => 'ssh://git@bitbucket.org/steinhustad/boxen-licenses.git' }

  include vagrant
  #vagrant::plugin { 'vagrant-veewee': }

  vagrant::plugin { 'vagrant-vmware-fusion':
      license => "/Users/${::boxen_user}/.boxen_licenses/vagrant-vmware-fusion.lic",
      require => Repository["/Users/${::boxen_user}/.boxen_licenses"]
  }

  #vagrant::box { 'squeeze64/vmware_fusion':
  #    source => 'https://s3.amazonaws.com/github-ops/vagrant/squeeze64-6.0.7-vmware_fusion.box'
  #}
}

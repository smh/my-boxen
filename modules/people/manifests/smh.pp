class people::smh {

  include modern_space_cadet

  include projects::all

  repository { "${::boxen_srcdir}/puppet-pckeyboardhack": source => 'smh/puppet-pckeyboardhack' }
  repository { "${::boxen_srcdir}/puppet-keyremap4macbook": source => 'smh/puppet-keyremap4macbook' }
  repository { "${::boxen_srcdir}/puppet-modern_space_cadet": source => 'smh/puppet-modern_space_cadet' }

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
}

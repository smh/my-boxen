class people::smh {

  include modern_space_cadet

  include projects::all

  repository { "${::boxen_srcdir}/puppet-pckeyboardhack": source => 'smh/puppet-pckeyboardhack' }
  repository { "${::boxen_srcdir}/puppet-keyremap4macbook": source => 'smh/puppet-keyremap4macbook' }
  repository { "${::boxen_srcdir}/puppet-modern_space_cadet": source => 'smh/puppet-modern_space_cadet' }
}

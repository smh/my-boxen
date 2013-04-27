class projects::boxen-web {
  boxen::project { 'boxen-web':
    postgresql => true,
    nginx      => true,
    ruby       => '1.9.3',
    source     => 'smh/boxen-web'
  }
}

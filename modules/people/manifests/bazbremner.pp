class people::bazbremner {
  include alfred
  include caffeine
  include chrome
  include dropbox
  include flux
  include gitx::dev
  include iterm2::colors::solarized_dark
  include iterm2::dev
  include notational_velocity::nvalt
  include sizeup
  include xquartz

  include osx::global::disable_autocorrect
  include osx::global::tap_to_click
  include osx::global::enable_keyboard_control_access
  include osx::global::key_repeat_delay
  include osx::global::key_repeat_rate
  include osx::no_network_dsstores
  include osx::finder::show_external_hard_drives_on_desktop
  include osx::finder::unhide_library

  class { 'osx::global::natural_mouse_scrolling':
    enabled => false
  }

  package {
    [
     'aspell',
     'awscli',
     'aws-shell',
     'bash-completion',
     'cask',
     'docker',
     'docker-compose',
     'docker-machine',
     'emacs',
     'gpg',
     'jq',
     'maven',
     'pass',
     'sipcalc',
     'the_silver_searcher',
     'tmux',
     'tree',
     ]:
     ensure => latest,
  }

  package {
    [
     'wget',
     ]:
     ensure => present,
  }

  package { 'python':
    ensure => present,
  } ->
  package {
    ['virtualenv', 'virtualenvwrapper']:
    ensure   => present,
    provider => pip,
  }

  $home = "/Users/${::luser}"
  $code = "${home}/code"
  $work = "${home}/gds"

  file { [$code, $work]:
    ensure => directory,
  }

  repository { "${home}/.emacs.d":
    source => 'git@github.com:bazbremner/dot-emacs.git',
  }

}

class people::samjsharpe::common_machine {

  include alfred::two
  include dropbox
  include firefox
  include gds_vpn_profiles
  include hub
  include iterm2::stable
  include mplayerx
  include ohmyzsh
  include packer
  include spectacle
  include spf13vim3
  include stay
  include turn-off-dashboard
  include unarchiver
  include vagrant
  include vagrant_no_vbox
  include virtualbox
  include zsh

  vagrant::plugin { 'vagrant-vmware-fusion': }

  file {"/Users/${::luser}/.oh-my-zsh/custom/samsharpe.zsh-theme":
    content => 'ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}:%{$fg[green]%}"
PROMPT=\'$(virtualenv_prompt_info)%{$reset_color%}[%{$fg[cyan]%}%2d$(git_prompt_info)%{$reset_color%}]$ \'
',
    require => Class['ohmyzsh']
  }

  # These are all Homebrew packages
  package {
    [
      'autojump',
      'ctags',
      'htop-osx',
      'nmap',
      'ntfs-3g',
      'osxutils',
      'parallel',
      'rbenv-bundler',
      'unrar',
      'wget',
      'zsh-completions',
    ]:
    ensure => present,
  }

  Boxen::Osx_defaults {
    user => $::luser,
  }

  # Settings from puppet-osx
  include osx::disable_app_quarantine
  include osx::dock::2d
  include osx::finder::show_all_on_desktop
  include osx::finder::unhide_library
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::no_network_dsstores

  boxen::osx_defaults { 'Put my Dock on the left':
    key    => 'orientation',
    domain => 'com.apple.dock',
    value  => 'left',
  }

  boxen::osx_defaults { 'Disable reopen windows when logging back in':
    key    => 'TALLogoutSavesState',
    domain => 'com.apple.loginwindow',
    value  => 'false',
  }

  exec { 'Disable Gatekeeper':
    command => 'spctl --master-disable',
    unless  => 'spctl --status | grep disabled',
  }
}

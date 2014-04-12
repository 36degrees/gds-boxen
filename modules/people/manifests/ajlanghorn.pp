class people::ajlanghorn {
  include adium
  include caffeine
  include chrome
  include encfs
  include gds-resolver
  include gds_vpn_profiles
  include git
  include iterm2::stable
  include osx
  include spotify
  include turn-off-dashboard
  include vagrant
  include vim
  include virtualbox
  include wget

# zsh is the shell
# ohmyzsh is extensions for zsh
  include zsh
  include ohmyzsh

  vagrant::plugin { 'vagrant-cachier': }
  # https://github.com/fgrehm/vagrant-cachier
  vagrant::plugin { 'vagrant-zz-multiprovider-snap': }
  # https://github.com/scalefactory/vagrant-multiprovider-snap

  # =================================================
  #
  # Dependency for puppet-vim

  file { "$home/.vimrc":
    ensure  => link,
    target  => "dotfiles/.vimrc",
    require => Exec['install dotfiles'],
    }

  vim::bundle { 'rodjek/vim-puppet': }

  include projects::deployment
  include projects::deployment::creds

  # These are all Homebrew packages
  package {
    [
      'ack',
      'autojump',
      'automake',
      'bash-completion',
      'findutils',
      'git',
      'gnu-sed',
      'gnupg',
      'graphviz',
      'openssl',
      'swaks',
      'tmux',
      'wget',
    ]:
    ensure => present,
  }

  $home       = "/Users/${::luser}"
  $projects   = "${home}/projects"
  $dotfiles   = "/Users/${::luser}/dotfiles"

  file { [$projects, $projects_personal]:
    ensure => directory,
  }

  exec { 'install dotfiles':
    command     => 'rake',
    cwd         => $dotfiles,
    logoutput   => true,
    refreshonly => true,
  }

}
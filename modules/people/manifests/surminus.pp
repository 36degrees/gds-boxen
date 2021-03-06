## Laura Martin boxen config
class people::surminus {
  # Include Infrastructure class
  include teams::infrastructure

  include alfred
  include chrome
  include firefox
  include gds_vpn_profiles
  include git
  include gitx
  include googledrive
  include hub
  include iterm2::stable
  include iterm2::colors::solarized_dark
  include ohmyzsh
  include screen
  include spotify
  include vagrant
  include virtualbox
  include zsh

  ## osx stuff

  osx::recovery_message { 'If this Mac is found, please call 07870 300 659': }

  $home    = "/Users/${::luser}"
  $mystuff = "${home}/surminus"

  ## dotfiles
  repository { "${mystuff}/dotfiles":
    source => 'surminus/dotfiles',
  }

  define createDotfile {
    file { "${home}/.${name}":
      ensure => 'link',
      target => "${mystuff}/dotfiles/${name}",
    }
  }

  $dotfiles = [
                'vimrc',
                'zshrc',
                'gitconfig'
              ]
  createDotfile { $dotfiles: }

  file { [ "${mystuff}", "${home}/.vim", "${home}/.vim/bundle", "${home}/.vim/autoload"]:
    ensure => directory,
  }

  class { 'gds_printers':
    ldap_username => "${::luser}",
  }

  ## homebrew
  package {
    [
      'autoconf',
      'autojump',
      'automake',
      'bash-completion',
      'cmake',
      'coreutils',
      'docker',
      'encfs',
      'fzf',
      'go',
      'htop-osx',
      'libxml2',
      'packer',
      'pass',
      'sl',
      'terraform',
      'vim',
      'wget',
    ]:
    ensure => present,
  }

# Sometimes these do not install properly because they require sudo. If they fail,
# run `sudo ls` or something to gain a sudo session for a time before running
# boxen.
package {
    [
      'gpgtools',
      'osxfuse',
      'xscreensaver',
    ]:
    ensure   => present,
    provider => 'brewcask',
  }

}

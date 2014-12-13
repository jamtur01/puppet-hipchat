# Class: puppet_hipchat::params
#
# Parameterize for Puppet platform.
#
class puppet_hipchat::params {

  $package_name = 'hipchat'
  $puppetboard  = 'false'
  $dashboard    = 'false'

  if $::is_pe or $::is_pe == 'true' {
    $puppetconf_path = '/etc/puppetlabs/puppet'
    $provider        = 'pe_gem'
    $owner           = 'pe-puppet'
    $group           = 'pe-puppet'
  } else {
    $puppetconf_path = '/etc/puppet'
    $provider        = 'gem'
    $owner           = 'puppet'
    $group           = 'puppet'
  }
}

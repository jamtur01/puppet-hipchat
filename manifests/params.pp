# Class: puppet_hipchat::params
#
# Parameterize for Puppet platform.
#
class puppet_hipchat::params {

  $package_name   = 'hipchat'
  $puppetboard    = false
  $dashboard      = false
  $api_version    = 'v1'

  if str2bool($::is_pe) {
    $install_hc_gem  = true
    $puppetconf_path = '/etc/puppetlabs/puppet'
    $provider        = 'pe_gem'
    $owner           = 'pe-puppet'
    $group           = 'pe-puppet'
  } elsif ($::puppetversion) and (versioncmp('4.0.0', $::puppetversion) < 1) {
    $puppetconf_path = '/etc/puppetlabs/puppet'
    $install_hc_gem  = false
    $owner           = 'puppet'
    $group           = 'puppet'
  } else {
    $install_hc_gem  = true
    $puppetconf_path = '/etc/puppet'
    $provider        = 'gem'
    $owner           = 'puppet'
    $group           = 'puppet'
  }
}

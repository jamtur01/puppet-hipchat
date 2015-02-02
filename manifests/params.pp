# Class: puppet_hipchat::params
#
# Parameterize for Puppet platform.
#
class puppet_hipchat::params {

  $package_name   = 'hipchat'
  $install_hc_gem = true
  $puppetboard    = false
  $dashboard      = false

  if str2bool($::is_pe) {
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

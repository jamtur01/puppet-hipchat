class puppet_hipchat::params {
  if $::is_pe == 'true' {
    $puppetconf_path = '/etc/puppetlabs/puppet'
    $provider        = 'pe_gem'
  } else {
    $puppetconf_path = '/etc/puppet'
    $provider        = 'gem'
  }
}

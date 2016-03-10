# Class: puppet_hipchat
#
# Send Puppet report information to HipChat
#
class puppet_hipchat (
  $api_key,
  $room,
  $server         = 'https://api.hipchat.com',
  $notify_color   = 'red',
  $notify_room    = false,
  $statuses       = [ 'failed' ],
  $config_file    = "${puppet_hipchat::params::puppetconf_path}/hipchat.yaml",
  $package_name   = $puppet_hipchat::params::package_name,
  $install_hc_gem = $puppet_hipchat::params::install_hc_gem,
  $provider       = $puppet_hipchat::params::provider,
  $owner          = $puppet_hipchat::params::owner,
  $group          = $puppet_hipchat::params::group,
  $puppetboard    = $puppet_hipchat::params::puppetboard,
  $dashboard      = $puppet_hipchat::params::dashboard,
  $api_version    = $puppet_hipchat::params::api_version,
  $proxy          = $puppet_hipchat::params::proxy,
) inherits puppet_hipchat::params {

  file { $config_file:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => '0440',
    content => template('puppet_hipchat/hipchat.yaml.erb'),
  }

  if $install_hc_gem {
    package { $package_name:
      ensure   => installed,
      provider => $provider,
    }
  }
}

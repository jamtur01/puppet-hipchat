# Class: puppet_hipchat
#
# Send Puppet report information to HipChat
#
class puppet_hipchat (
  $api_key,
  $room,
  $notify_color = 'red',
  $notify_room  = false,
  $statuses     = [ 'failed' ],
  $config_file  = "${puppet_hipchat::params::puppetconf_path}/hipchat.yaml",
  $package_name = $puppet_hipchat::params::package_name,
  $provider     = $puppet_hipchat::params::provider,
  $owner        = $puppet_hipchat::params::owner,
  $group        = $puppet_hipchat::params::group,
  $puppetboard  = $puppet_hipchat::params::puppetboard,
  $dashboard    = $puppet_hipchat::params::dashboard,
) inherits puppet_hipchat::params {

  file { $config_file:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => '0440',
    content => template('puppet_hipchat/hipchat.yaml.erb'),
  }

  package { $package_name:
    ensure   => installed,
    provider => $provider,
  }
}

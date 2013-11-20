class puppet_hipchat (
  $api_key,
  $room,
  $notify_color = 'red',
  $notify_room  = false,
  $statuses     = [ 'failed' ],
  $config_file  = "${puppet_hipchat::params::puppetconf_path}/hipchat.yaml",
  $package_name = $puppet_hipchat::params::package_name,
  $provider     = $puppet_hipchat::params::provider,
) inherits puppet_hipchat::params {

  file { $config_file:
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0440',
    content => template('puppet_hipchat/hipchat.yaml.erb'),
  }

  package { $package_name:
    ensure   => installed,
    provider => $provider,
  }
}

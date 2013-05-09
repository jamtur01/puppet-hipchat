class puppet_hipchat (
  $api_key,
  $room,
  $notify_color = 'red',
  $notify_room  = false,
  $statuses     = [ 'failed' ],
  $config_file  = '/etc/puppet/hipchat.yaml',
){

  file { $config_file:
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0440',
    content => template('puppet_hipchat/hipchat.yaml.erb'),

  }

}


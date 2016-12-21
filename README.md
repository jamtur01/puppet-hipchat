# Puppet Hipchat

[![Puppet Forge](http://img.shields.io/puppetforge/v/jamtur01/puppet_hipchat.svg)](https://forge.puppetlabs.com/jamtur01/puppet_hipchat)
[![Puppet Forge downloads](https://img.shields.io/puppetforge/dt/jamtur01/puppet_hipchat.svg)](https://forge.puppetlabs.com/jamtur01/puppet_hipchat)
[![Puppet Forge score](https://img.shields.io/puppetforge/f/jamtur01/puppet_hipchat.svg)](https://forge.puppetlabs.com/jamtur01/puppet_hipchat)
[![Build Status](https://travis-ci.org/jamtur01/puppet-hipchat.svg?branch=master)](https://travis-ci.org/jamtur01/puppet-hipchat)


## Migrated

This module has been migrated to voxpupuli: [https://github.com/voxpupuli/puppet-report_hipchat](https://github.com/voxpupuli/puppet-report_hipchat)

## Description

A Puppet report handler for sending notifications of Puppet runs to [HipChat](http://www.hipchat.com).

## TravisCI status

[![Build Status](https://travis-ci.org/jamtur01/puppet-hipchat.svg?branch=master)](https://travis-ci.org/jamtur01/puppet-hipchat)

## Requirements

* `ruby >= 1.9.3` Note: PE puppet-master 3.x and PE/opensource puppetserver bundled versions of ruby should meet required version.
* `hipchat >= 0.12.0`
* `puppet`

For Cent/RHEL 6 users running open source puppet-master 3.x, puppet utilizes the system ruby as such the latest repository provided version of ruby is 1.8.7, this means use of RVM or some other method to install a modern version of ruby will be required.

For the room in which you want to receive puppet notifications, add a new BYO Integration. This will return an example url: `https://example.hipchat.com/v2/room/123456789/notification?auth_token=WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S`
        `https://example.hipchat.com` is the server (you can use on premise hipchat servers as well)
        `v2` is the api version
        `123456789` is the room
        `WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S` is the api_key

## Installation

### Installation utilizing puppet

```puppet
class { 'puppet_hipchat':
  server         => 'https://example.hipchat.com',
  api_version    => 'v2',
  api_key        => 'WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S',
  room           => '123456789',
  install_hc_gem => true,
  provider       => 'puppetserver_gem',
}
```

With puppetboard link: 

```puppet
class { 'puppet_hipchat':
  server         => 'https://example.hipchat.com',
  api_version    => 'v2',
  api_key        => 'WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S',
  room           => '123456789',
  install_hc_gem => true,
  provider       => 'puppetserver_gem',
  puppetboard    => 'https://puppetboard.test.local',
}
```

With dashboard link:

```puppet
class { 'puppet_hipchat':
  server         => 'https://example.hipchat.com',
  api_version    => 'v2',
  api_key        => 'WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S',
  room           => '123456789',
  install_hc_gem => true,
  provider       => 'puppetserver_gem',
  dashboard      => 'https://dashboard.test.local',
}
```

If you need to use a proxy to reach the hipchat server:

```puppet
class { 'puppet_hipchat':
  server         => 'https://example.hipchat.com',
  api_version    => 'v2',
  api_key        => 'WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S',
  room           => '123456789',
  install_hc_gem => true,
  provider       => 'puppetserver_gem',
  proxy          => 'http://proxy.test.local:8080',
}
```

Where provider is the following:
* `puppetserver_gem` used for opensource and pe puppetserver requires [puppetlabs-pe_gem](https://forge.puppet.com/puppetlabs/puppetserver_gem)
* `pe_gem` used for PE puppet master 3.x requires [puppetlabs-pe_gem](https://forge.puppet.com/puppetlabs/pe_gem)
* `gem` used for opensource puppet-master 

Lastly Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = hipchat
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

### Manual Installation

1.  Install the `hipchat` gem on your Puppet server

*NOTE FOR PE/Open Source puppetserver package 2.0.0+ USERS*:  You must install the `hipchat` gem using the
puppetserver gem utility:

        $ /opt/puppetlabs/bin/puppetserver gem install hipchat

*NOTE FOR PE puppet-master USERS*: You must install the `hipchat` gem using the
puppet-bundled gem library:

        $ /opt/puppet/bin/gem install hipchat
        
*NOTE FOR Open Source puppet-master USERS*: You must install the `hipchat` gem using the system gem utility:
        
        $ sudo gem install hipchat


2.  Install puppet-hipchat as a module in your Puppet master's module
    path.

3.  Update the `hipchat_server`, `hipchat_api_version`, `hipchat_api`, `hipchat_room` variables in the
    `hipchat.yaml` file with your Hipchat connection details and copy
    the file to `/etc/puppet/` or for PE/OpenSource puppetserver
    `/etc/puppetlabs/puppet`.
        
        ---
        :hipchat_server: 'https://test.hipchat.com'
        :hipchat_api_version: 'v2',
        :hipchat_api: 'WzP0dc4oEESuSmF2WJT23GtL5mili9uXof73M48S'
        :hipchat_room: '123456789'
        

4.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = hipchat
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

6.  Run the Puppet client and sync the report as a plugin

Usage
-----

* An option to notify users in the room `hipchat_notify` defaults to
  `false`.

* You can also change the default notification color from yellow to red,
  green, purple or random.

* The `hipchat_statuses` should be an array of statuses to send
  notifications for and defaults to `'failed'`. Specify `'all'` to
  receive notifications from all Puppet runs.

* In order to send notifications through proxy server set
  `hipchat_proxy` to your HTTP proxy URL using this format:

    'http://username:password@proxy_host:proxy_port'

* If you use [Puppetboard](https://github.com/nedap/puppetboard) set
  `hipchat_puppetboard` to the base URL of your Puppetboard
  installation, e.g. `'http://puppetboard.example.com'` and a link to the
  node's latest report will be send with the message to HipChat. An
  example file is included.

  *NOTE FOR PUPPETBOARD 0.1.2+ USERS*: if you are using environments other than production
  you will need to either configure puppetboard default environment to * or set `hipchat_server`
  to append /%2A, ex: `:hipchat_server: http://hipchat.test.local/%2A` otherwise you will receive
  a not found error for any nodes in environments other than `production`.

* To temporarily disable HipChat notifications add a file named
  `hipchat_disabled` in the same path as `hipchat.yaml`. Removing it
  will re-enable notifications.

    $ touch /etc/puppet/hipchat_disabled

Team
----

Maintainer: [James Powis](https://github.com/james-powis)

Original author: James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

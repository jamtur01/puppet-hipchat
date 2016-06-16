puppet-hipchat
==============

Description
-----------

A Puppet report handler for sending notifications of Puppet runs to [HipChat](http://www.hipchat.com).

TravisCI status
---------------

[![Build Status](https://travis-ci.org/jamtur01/puppet-hipchat.svg?branch=master)](https://travis-ci.org/jamtur01/puppet-hipchat)

Requirements
------------

* `hipchat >= 0.12.0`
* `puppet`

Installation
------------

1.  Install the `hipchat` gem on your Puppet master

        $ sudo gem install hipchat

*NOTE FOR PUPPET ENTERPRISE USERS*: You must install the `hipchat` gem using the
puppet-bundled gem library:

        $ /opt/puppet/bin/gem install hipchat

*NOTE FOR AIO package 2.0.0 USERS*:  You must install the `hipchat` gem using the
puppetserver gem utility:

        $ /opt/puppetlabs/bin/puppetserver gem install hipchat

2.  Install puppet-hipchat as a module in your Puppet master's module
    path.

3.  Create a HipChat API key [here](https://www.hipchat.com/groups/api)
    with a type of Admin. Record the API key that is generated.

4.  Update the `hipchat_api` and `hipchat_room` variables in the
    `hipchat.yaml` file with your Hipchat connection details and copy
    the file to `/etc/puppet/` or for Puppet Enterpise
    `/etc/puppetlabs/puppet`.

5.  Enable pluginsync and reports on your master and clients in `puppet.conf`

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

* To temporarily disable HipChat notifications add a file named
  `hipchat_disabled` in the same path as `hipchat.yaml`. Removing it
  will re-enable notifications.

    $ touch /etc/puppet/hipchat_disabled

* Modern hipchat installations may not support the default v1 api set
  `hipchat_api_version` to v2 for modern api support.

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

require 'spec_helper_acceptance'

describe 'puppet-hipchat' do
  context 'configure and send hipchat notification' do
    it 'should work with no errors' do
      # Because of puppetserver_gem not always resolving due to puppetserver
      # install cleanup, we will install the prerequisites first
      version = ENV['PUPPETSERVER_VERSION'] || 'present'
      pp = <<-EOS
      class { 'puppetserver::repository': } ->
      class { 'puppetserver':
        version => #{version},
        config  => {
          'java_args'     => {
            'xms'         => '256m',
            'xmx'         => '256m',
            'maxpermsize' => '512m',
          },
        },
      }
      host { 'puppet':
        ip => '127.0.0.1',
      }
      EOS
      apply_manifest(pp, :catch_failures => true)

      # Now run the module
      pp = <<-EOS
      service { 'puppetserver':
        ensure => running
      }
      ini_setting {'report':
        ensure  => present,
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        section => 'master',
        setting => 'report',
        value   => 'true',
        notify  => Service['puppetserver'],
      }
      ini_setting {'reports':
        ensure  => present,
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        section => 'master',
        setting => 'reports',
        value   => 'hipchat',
        notify  => Service['puppetserver'],
      }
      class {'::puppet_hipchat': 
        api_key        => 'mykey',
        room           => 'myroom',
        statuses       => ['all', 'testing'],
        install_hc_gem => true,
        provider       => 'puppetserver_gem',
        notify         => Service['puppetserver'],
      }
      EOS

      apply_manifest(pp, :catch_failures => true)

      # run the agent, this will cause the reporting handler generate a tmp file 
      # to show it executed properly
      agent = only_host_with_role(hosts, 'agent')
      expect(run_agent_on(agent).exit_code).to be_zero

      # validate idempotence
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/tmp/hipchat-notified.txt') do
      it { should be_file }
    end
  end
end

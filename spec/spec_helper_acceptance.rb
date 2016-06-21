require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

version = ENV['PUPPET_VERSION'] || '1.5.2'
install_puppet_agent_on(hosts, {:puppet_agent_version => version})

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  fixture_modules = File.join(proj_root, 'spec', 'fixtures', 'modules')

  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    path = File.expand_path(File.dirname(__FILE__) + '/../').split('/')

    # Install module
    puppet_module_install(source: proj_root, module_name: 'puppet_hipchat')

    # Install Dependencies
    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib')

      # needed to test reporting
      on host, puppet('module', 'install', 'camptocamp-puppetserver')
      on host, puppet('module', 'install', 'puppetlabs-inifile')
      on host, puppet('module', 'install', 'puppetlabs-puppetserver_gem')
    end
  end
end

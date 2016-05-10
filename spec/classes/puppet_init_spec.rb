require 'spec_helper'

describe 'puppet_hipchat', :type => :class do
  let(:facts) { { :is_pe => false } }

  describe "default" do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :server => 'myserver' } }
    it { should contain_package('hipchat').with(:provider => 'gem') }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_api: mykey/) }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_room: myroom/) }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_server: myserver/) }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_api_version: v1\n/) }
    it { should contain_file('/etc/puppet/hipchat.yaml').without(:content => /:hipchat_proxy:/) }
    it { should contain_file('/etc/puppet/hipchat.yaml').without(:content => /:hipchat_puppetboard:/) }
    it { should contain_file('/etc/puppet/hipchat.yaml').without(:content => /:hipchat_dashboard:/) }
  end

  describe "use api version 2" do
    let(:params) {{  :api_key => 'mykey', :room => 'myroom', :server => 'myserver', :api_version => 'v2' }}
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_api_version: v2/) }
  end

  describe "specify file location" do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :config_file => '/tmp/foo' } }
    it { should contain_file('/tmp/foo') }
  end

  describe 'no hipchat gem' do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :install_hc_gem => false } }
    it { should_not contain_package('hipchat') }
  end

  describe 'on pe' do
    let(:facts) { { :is_pe => true } }
    let(:params) { { :api_key => 'mykey', :room => 'myroom' } }
    it { should contain_package('hipchat').with(:provider => 'pe_gem') }
    it { should contain_file('/etc/puppetlabs/puppet/hipchat.yaml') }
  end

  describe 'on puppet 4' do
    let(:facts) { { :puppetversion => '4.0.0' } }
    let(:params) { { :api_key => 'mykey', :room => 'myroom' } }
    it { should_not contain_package('hipchat') }
    it { should contain_file('/etc/puppetlabs/puppet/hipchat.yaml') }
  end

  describe 'with proxy' do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :server => 'myserver', :proxy => 'myproxy' } }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_proxy: myproxy\n/) }
  end

  describe 'with puppetboard' do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :server => 'myserver', :puppetboard => 'mypuppetboard' } }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_puppetboard: mypuppetboard\n/) }
  end

  describe 'with dashboard' do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :server => 'myserver', :dashboard => 'mydashboard' } }
    it { should contain_file('/etc/puppet/hipchat.yaml').with(:content => /:hipchat_dashboard: mydashboard\n/) }
  end
end

require 'spec_helper'

describe 'puppet_hipchat', :type => :class do

  describe "default" do
    let(:params) { { :api_key => 'mykey', :room => 'myroom' } }

    it { should contain_file('/etc/puppet/hipchat.yaml') }
  end

  describe "specify file location" do
    let(:params) { { :api_key => 'mykey', :room => 'myroom', :config_file => '/tmp/foo' } }

    it { should contain_file('/tmp/foo') }

  end

end

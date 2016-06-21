source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :unit_tests do
  gem 'json',                   :require => false
  gem 'metadata-json-lint',     :require => false
  gem 'puppet-lint',            :require => false           
  gem 'puppet-syntax',          :require => false
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rake',                   :require => false         
  gem 'rspec-puppet',           :require => false
end

group :system_tests do
  gem 'vagrant-wrapper', :require => false
  gem 'beaker',          :require => false
  gem 'specinfra',       :require => false
  gem 'beaker-rspec',    :require => false
  gem 'serverspec',      :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end


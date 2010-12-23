source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'haml-rails'
gem 'inherited_resources'
gem 'has_scope'
gem 'will_paginate', '3.0.pre2'


# Style
gem "compass", ">= 0.10.6"
#gem 'simple_form'

#MongoDB
gem 'bson_ext'
gem 'mongoid', '>= 2.0.0.beta.20'

#security
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :branch => 'master'
gem 'omniauth'


#monitoring
gem 'rpm_contrib'
#gem 'newrelic_rpm'



group :development do
  gem 'capistrano'
  gem 'nifty-generators'
  #gem "hpricot", "0.8.2" # Only required for 'rails g devise:views'
  #gem "ruby_parser", "2.0.5" # Only required for 'rails g devise:views'
end


group :test, :development do
  gem 'rspec-rails', '>= 2.0.0.beta.22'
  gem 'spork', '>= 0.9.0.rc2'
  gem 'mocha'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'ruby-debug19', :require => 'ruby-debug'
  #gem 'ruby-debug'
  gem 'faker'

  #irb stuff
  gem 'wirble'
  gem 'hirb'
  gem 'awesome_print'
  gem 'bond'
  gem 'sketches'

  #factories
  gem 'factory_girl_rails', :git => 'git://github.com/thoughtbot/factory_girl_rails.git'
  gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git'
end

group :test do
  gem 'simplecov', '>= 0.3.5', :require => false
  gem 'webrat'
  gem 'capybara'
  gem 'database_cleaner'
end


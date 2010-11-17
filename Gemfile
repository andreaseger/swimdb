source 'http://rubygems.org'

gem 'rails', '3.0.1'

gem 'haml-rails'
gem 'inherited_resources'
gem 'has_scope'

#MongoDB
gem 'bson_ext'
gem 'mongoid', '>= 2.0.0.beta.20'

#security
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :branch => 'master'
gem 'omniauth'

group :development do
  gem 'capistrano'
  gem 'nifty-generators'
  #gem "hpricot", "0.8.2" # Only required for 'rails g devise:views'
  #gem "ruby_parser", "2.0.5" # Only required for 'rails g devise:views'
end


group :test, :development do
  gem 'rspec-rails', '>= 2.0.0.beta.22'
  gem 'spork', '>= 0.9.0.rc2'
  #gem 'mocha'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'ruby-debug19', :require => 'ruby-debug'
  #gem 'ruby-debug'
end

group :test do
  gem 'simplecov', '>= 0.3.5', :require => false
  gem 'webrat'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
#  gem 'rack-test',
#    :git => 'git://github.com/brynary/rack-test.git'
end


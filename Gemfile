source 'http://rubygems.org'

gem 'rails', '3.0.1'

gem 'haml-rails'
gem 'inherited_resources'
gem 'has_scope'

gem 'capistrano'

#MongoDB
gem 'bson_ext'
gem 'mongo_mapper',
    :git =>"git://github.com/jnunemaker/mongomapper.git", :branch => "master"

#security
gem 'devise'
gem 'devise-mongo_mapper',
    :git    => "git://github.com/collectiveidea/devise-mongo_mapper"

group :development do
  gem 'nifty-generators'
  #gem "hpricot", "0.8.2" # Only required for 'rails g devise:views'
  #gem "ruby_parser", "2.0.5" # Only required for 'rails g devise:views'
  #gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'ruby-debug'
end


group :test, :development do
  gem 'rspec-rails', '>= 2.0.0.beta.22'
  gem 'spork', '>= 0.9.0.rc2'
  #gem 'mocha'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'cucumber'
  gem 'cucumber-rails'
end

group :test do
  #gem 'simplecov'
  gem 'webrat'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end


source 'http://rubygems.org'

gem 'rails', '3.0.0'

gem 'haml-rails'
gem 'inherited_resources'

#MongoDB
gem 'bson_ext'
gem 'mongo_mapper',
    :git =>"git://github.com/jnunemaker/mongomapper.git", :branch => "rails3"

#security
gem 'devise'
gem 'devise-mongo_mapper',
    :git    => "git://github.com/collectiveidea/devise-mongo_mapper"

group :development do
  gem "hpricot", "0.8.2" # Only required for 'rails g devise:views'
  gem "ruby_parser", "2.0.5" # Only required for 'rails g devise:views'
  #gem 'ruby-debug19', :require => 'ruby-debug'
end


group :test, :development do
  gem 'rspec-rails', '>= 2.0.0.beta.22'
  gem 'spork'
  #gem 'mocha'
  gem 'autotest'
  gem 'cucumber'
  gem 'cucumber-rails'
end

group :test do
  gem 'simplecov'
  gem 'webrat'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end


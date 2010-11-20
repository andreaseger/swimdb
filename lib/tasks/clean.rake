namespace :db do
  desc "Raise an error unless the RAILS_ENV is development"
  task :development_environment_only do
    raise "Hey, development only you monkey!" unless ::Rails.env == 'development'
  end
  desc "clean up the hole database aka erase all that stuff"
  task :clean => ['environment', 'db:development_environment_only'] do
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongo_mapper"
    DatabaseCleaner.clean
    puts "cleaned up the database"
  end
end


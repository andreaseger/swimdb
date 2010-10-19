require 'bundler/capistrano'

set :application, "swimdb"

set :repository,  "git@github.com:sch1zo/swimdb.git"
set :branch, "master"
set :scm, :git
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true

server "foooo", :app, :web, :db, :primary => true


set :deploy_to, "/home/rails"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


#not sure if I need this but the plesk user has to have access
namespace :permissions do
  task :set_group do
    run "#{try_sudo} chgrp psaserv -R #{current_release}"
    run "#{try_sudo} chmod g+rws -R #{current_release}"
  end
end
# HOOKS
after "deploy:update_code" do
  permissions.set_group
end


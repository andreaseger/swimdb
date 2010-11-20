namespace :user do
  desc "Create a new User from params"
  task :create, :username, :email, :password, :needs => [:show_env, :environment] do |t, args|
    puts "Args were: #{args}"
    hash = {:username => args[:username], :email => args[:email], :password => args[:password], :password_confirmation => args[:password] }
    user = User.new(hash)
    if user.save
      puts "Sucessfully created a new User #{args[:username]} with password #{args[:password]}"
    else
      puts "Could not create the User: #{user.errors.full_messages}"
    end
  end

  desc "List all Users"
  task :list => [:show_env, :environment] do
    username = "username".ljust(15)
    email = "email".ljust(25)
    created_at = "created_at".ljust(15)
    last_sign_in_at = "last_sign_in_at".ljust(15)
    puts "|#:\t#{username}\t#{email}\t#{created_at}\t#{last_sign_in_at}|"
    puts "|" + "-"*86 + "|"
    User.all.each_with_index do |user, index|
      username = user.username.ljust(15)
      email = user.email.ljust(25)
      created_at = user.created_at.strftime("%d.%m.%y %H:%M").ljust(15)
      if user.last_sign_in_at
        last_sign_in_at = user.last_sign_in_at.strftime("%d.%m.%y %H:%M").ljust(15)
      else
        last_sign_in_at = "".ljust(15)
      end
      puts "|#{index}:\t#{username}\t#{email}\t#{created_at}\t#{last_sign_in_at}|"
    end
  end
end

namespace :admin do
  desc "Create a new Admin from params"
  task :create, :email, :password, :needs => [:show_env, :environment] do |t, args|
    puts "Args were: #{args}"
    hash = {:email => args[:email], :password => args[:password], :password_confirmation => args[:password] }
    admin = Admin.new(hash)
    if admin.save
      puts "Sucessfully created a new Admin '#{args[:email]}' with password '#{args[:password]}'"
    else
      puts "Could not create the Admin: #{admin.errors.full_messages}"
    end
  end
  desc "List all Admins"
  task :list => [:show_env, :environment] do
    email = "email".ljust(25)
    created_at = "created_at".ljust(15)
    last_sign_in_at = "last_sign_in_at".ljust(15)
    puts "|#:\t#{email}\t#{created_at}\t#{last_sign_in_at}|"
    puts "|" + "-"*70 + "|"
    Admin.all.each_with_index do |user, index|
      email = user.email.ljust(25)
      created_at = user.created_at.strftime("%d.%m.%y %H:%M").ljust(15)
      if user.last_sign_in_at
        last_sign_in_at = user.last_sign_in_at.strftime("%d.%m.%y %H:%M").ljust(15)
      else
        last_sign_in_at = "".ljust(15)
      end
      puts "|#{index}:\t#{email}\t#{created_at}\t#{last_sign_in_at}|"
    end
  end
end

desc "shows the current environment"
task :show_env do
  puts "Running Task on \"#{::Rails.env}\""
end


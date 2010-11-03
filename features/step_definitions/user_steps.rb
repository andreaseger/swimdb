Then /^I should have a user named "([^"]*)"$/ do |username|
  User.where(:username => username).first.should_not be_nil
end

Given /^(?:|I )am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^(?:|I )have one\s+user "([^\"]*)"(?: with password "([^\"]*)"(?: and email "([^\"]*)")?)?$/ do |username,password,email|
  email = 'testing@man.net' unless email
  username = 'Testing man' unless username
  password = 'secretpass' unless password

  User.new(:email => email,
           :username => username,
           :password => password,
           :password_confirmation => password).save!
end


#Given /^(?:|I )have one\s+user "([^\"]*)" with password "([^\"]*)" and username "([^\"]*)"$/ do |email, password, username|
#  User.new(:email => email,
#           :username => username,
#           :password => password,
#           :password_confirmation => password).save!
# end

Given /^(?:|I )am a new, authenticated user(?: named "([^\"]*)"(?: with email "([^\"]*)"(?: and password "([^\"]*)")?)?)?$/ do |username, email, password|
  email = 'testing@man.net' unless email
  username = 'Testing man' unless username
  password = 'secretpass' unless password

  Given %{I have one user "#{username}" with password "#{password}" and email "#{email}"}
  And %{I go to userlogin}
  And %{I fill in "user_username" with "#{username}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

Then /(?:|I )should have a user "([^\"]*)" with email "([^\"]*)"/ do |username, email|
  u = User.where(:username => username)
  u.email.should == email
end

Then /^(?:|I )should have a user with "([^\"]*)" authentication$/ do |provider|
  User.last.authentications.first.provider.should == provider
end

Then /^(?:|I )should not have a user "([^"]*)"$/ do |username|
  User.where(:username => username).nil?.should be_true
end

Given /^I am a new, authenticated omniauth user$/ do
  Given %{I am a new, authenticated user}
  User.last.authentications.create!(:uid => '019283746510293', :provider => 'dummy')
end


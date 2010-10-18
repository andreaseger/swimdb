Given /^(?:|I )am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^(?:|I )have one\s+user "([^\"]*)" with password "([^\"]*)" and username "([^\"]*)"$/ do |email, password, username|
  User.new(:email => email,
           :username => username,
           :password => password,
           :password_confirmation => password).save!
end
Given /^(?:|I )am a new, authenticated user(?: named "([^\"]*)"(?: with email "([^\"]*)"(?: and password "([^\"]*)")?)?)?$/ do |username, email, password|
  email = 'testing@man.net' unless email
  username = 'Testing man' unless username
  password = 'secretpass' unless password

  Given %{I have one user "#{email}" with password "#{password}" and username "#{username}"}
  And %{I go to login}
  And %{I fill in "user_username" with "#{username}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

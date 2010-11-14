Given /^(?:|I )have one\s+admin "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Admin.create!(:email => email,
           :password => password,
           :password_confirmation => password)
end

Given /^(?:|I )am a new, authenticated admin(?: with email "([^\"]*)"(?: and password "([^\"]*)")?)?$/ do |email, password|
  email = 'testing@man.net' unless email
  password = 'secretpass' unless password

  Given %{I have one admin "#{email}" with password "#{password}"}
  And %{I go to adminlogin}
  And %{I fill in "admin_email" with "#{email}"}
  And %{I fill in "admin_password" with "#{password}"}
  And %{I press "Sign in"}
end


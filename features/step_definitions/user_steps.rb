Then /^I should have a user named "([^"]*)"$/ do |username|
  User.where(:username => username).first.should_not be_nil
end


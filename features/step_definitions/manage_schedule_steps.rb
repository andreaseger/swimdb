Given /^I have no Schedules$/ do
  Schedule.delete_all
end

Given /^I have (\d+) Schedules "([^"]*)" and "([^"]*)"$/ do |num, arg2, arg3|
  Schedule.delete_all
  Schedule.create!(:name => arg2, :description => 'foo', :items => [Item.new(:text => "400m")])
  Schedule.create!(:name => arg3, :description => 'foo', :items => [Item.new(:text => "400m")])
end


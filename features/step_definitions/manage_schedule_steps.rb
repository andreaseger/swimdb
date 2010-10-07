Given /^I have no Schedules$/ do
  Schedule.delete_all
end

Given /^I have (\d+) Schedules "([^"]*)" and "([^"]*)"$/ do |num, arg2, arg3|
  Schedule.delete_all
  Schedule.create!(:name => arg2, :description => 'foo', :items => [Item.new(:text => "400m")])
  Schedule.create!(:name => arg3, :description => 'foo', :items => [Item.new(:text => "400m")])
end

When /^I click on the "([^"]*)" link$/ do |link_name|
  click_link(link_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" fieldset$/ do |field, value, index, selector|
  matcher = "fieldset#{selector}"
  path = Capybara::XPath.from_css(matcher).paths.first + "[#{index}]"
  within(:xpath, path) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" fieldset$/ do |value, field, index, selector|
  matcher = "fieldset#{selector}"
  path = Capybara::XPath.from_css(matcher).paths.first + "[#{index}]"
  within(:xpath, path) do
    select(value, :from => field)
  end
end

Then /^I should have (\d+) schedule$/ do |number|
  Schedule.count.should == number.to_f
end


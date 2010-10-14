Given /^(?:|I )have no schedules$/ do
  Schedule.delete_all
end

Given /^(?:|I )have (\d+) schedules "([^"]*)" and "([^"]*)"$/ do |num, arg2, arg3|
  Schedule.delete_all
  Schedule.create!(:name => arg2, :description => 'foo', :items => [Item.new(:text => "400m")])
  Schedule.create!(:name => arg3, :description => 'foo', :items => [Item.new(:text => "400m")])
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" ([^"]*)$/ do |field, value, index, selector, tag|
  matcher = "#{tag}#{selector}"
  path = Capybara::XPath.from_css(matcher).paths.first + "[#{index}]"
  within(:xpath, path) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" ([^"]*)$/ do |value, field, index, selector|
  matcher = "#{tag}#{selector}"
  path = Capybara::XPath.from_css(matcher).paths.first + "[#{index}]"
  within(:xpath, path) do
    select(value, :from => field)
  end
end

Then /^(?:|I )should have (\d+) schedules$/ do |number|
  Schedule.count.should == number.to_f
end

Given /^(?:|I )have a schedule "([^"]*)" with the description "([^"]*)" and the following items:$/ do |name, description, table|
  # table is a Cucumber::Ast::Table
  schedule = Schedule.new(:name => name, :description => description)
  table.hashes.each do |hash|
    schedule.items.build(hash)
  end
  schedule.save
end

When /^(?:|I )follow "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" fieldset$/ do |link, index, selector|
  matcher = "fieldset#{selector}"
  path = Capybara::XPath.from_css(matcher).paths.first + "[#{index}]"
  within(:xpath, path) do
    click_link(link)
  end
end

When /^(?:I )click destroy$/ do
  page.evaluate_script('window.confirm = function() { return true; }')
  page.click('Destroy')
end

Then /^the schedules user should be "([^"]*)"$/ do |username|
  Schedule.last.user.username.should == username
end


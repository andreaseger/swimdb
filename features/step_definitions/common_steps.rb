When /^.* \(manualstep\)$/ do
end

Then /^debugger$/ do
  debugger
end

When /^(?:I )click "([^"]*)"$/ do |click|
  page.evaluate_script('window.confirm = function() { return true; }')
  page.click_link_or_button(click)
end

When /^(?:I )click "([^"]*)" within "([^"]*)"$/ do |click, selector|
  page.evaluate_script('window.confirm = function() { return true; }')
  path = XPath.css(selector).first.to_xpath
  within(:xpath, path) do
    page.click_link_or_button(click)
  end
end

Then /^(?:|I )should have (\d+) schedules$/ do |number|
  Schedule.count.should == number.to_f
end

Then /^I should have (\d+) Users$/ do |number|
  User.count.should == number.to_f
end

Then /^I should have (\d+) Authenications$/ do |number|
  Authentication.count.should == number.to_f
end


Given /^(?:|I )have no schedules$/ do
  Schedule.delete_all
end

Given /^(?:|I )have (\d+) schedules "([^"]*)" and "([^"]*)"$/ do |num, arg2, arg3|
  Schedule.create!(:name => arg2, :description => 'foo', :items => [Item.new(:text => "400m")], :taggings => "foo, bar")
  Schedule.create!(:name => arg3, :description => 'foo', :items => [Item.new(:text => "400m")], :taggings => "foo, goo")
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" ([^"]*)$/ do |field, value, index, selector, tag|
  matcher = "#{tag}#{selector}"
  path = XPath.css(matcher).first.to_xpath + "[#{index}]"
  within(:xpath, path) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" ([^"]*)$/ do |value, field, index, selector, tag|
  matcher = "#{tag}#{selector}"
  path = XPath.css(matcher).first.to_xpath + "[#{index}]"
  within(:xpath, path) do
    select(value, :from => field)
  end
end

Given /^(?:|I )have a schedule "([^"]*)" with the description "([^"]*)" and the following items:$/ do |name, description, table|
  # table is a Cucumber::Ast::Table
  schedule = Schedule.new(:name => name, :description => description, :user => User.last, :taggings => "goo foo")
  table.hashes.each do |hash|
    schedule.items.build(hash)
  end
  schedule.save
end

When /^(?:|I )follow "([^"]*)" within the (\d)(?:st|nd|rd|th) "([^"]*)" fieldset$/ do |link, index, selector|
  matcher = "fieldset#{selector}"
  path = XPath.css(matcher).first.to_xpath + "[#{index}]"
  within(:xpath, path) do
    click_link_or_button(link)
  end
end

Then /^the schedules user should be "([^"]*)"$/ do |username|
  Schedule.last.user.username.should == username
end

Given /^(?:|I )have a schedule "([^"]*)" with the following tags "([^"]*)"$/ do |name, taggings|
  Schedule.create!(:name => name, :description => "Lorem", :items => [Item.new(:text => "400m")], :taggings => taggings)
end

When /(?:|I )add the following items/ do |table|
  table.each_with_index do |hash, index|
    level = hash[:level]
    text = hash[:text]
    When %{I follow "(add item)"}
     And %{I select "#{level}" from "level" within the #{index+1} ".item" fieldset}
     And %{I fill in "#{text}" for "text" within the #{index+1} ".item" fieldset}
  end
end


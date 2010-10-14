Given /^I have a schedule with following tags "([^"]*)"$/ do |taggings|
  Factory(:full_distance_test1, :taggings => taggings)
end


Given /^The schedule has no comments$/ do
  Schedule.last.comments.clear
end

Then /^The schedule should have no comments$/ do
  Schedule.last.comments.should == []
end


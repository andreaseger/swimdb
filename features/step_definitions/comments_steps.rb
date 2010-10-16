Given /^The schedule has no comments$/ do
  Schedule.last.comments.clear
end


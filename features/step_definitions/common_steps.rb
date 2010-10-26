When /^.* \(manualstep\)$/ do
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


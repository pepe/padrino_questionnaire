Given /^I visit '(.+)'$/ do |url|
  visit(url)
end
Given /^I am viewing '(.+)'$/ do |url|
  Given "I visit '#{url}'"
end
Then /^I should see '(.+)'$/ do |text|
  page.should have_content(text)
end
Then /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  fill_in(field, :with => value)
end
When /^I press '(.*)'$/ do |name|
  click_button(name)
end
Then /^I choose '(.*)'$/ do |value|
  choose(value) 
end
Given /^I will get mail$/ do
  Pony.should_receive(:mail)
end
Then /^I follow '(.+)'$/ do |link|
  click_link link
end
When /^I select '(.+)' from '(.+)'$/ do |value, field|
  select(value, :from => field) 
end
When /^I can select '(.+)' from '(.+)'$/ do |value, field|
  select(value, :from => field) 
end
Then /^I can choose '(.+)'$/ do |value|
  choose(value) 
end
When /^I dump$/ do
  save_and_open_page
end

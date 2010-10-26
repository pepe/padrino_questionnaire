# encoding: utf-8

Given /^I started new questionnaire$/ do
  Given "I visit '/'"
  Then "I follow 'Pokračujte ve vyplnění dotazníku'"
end
Given /^I filled first part of questionnaire$/ do
  Given "I started new questionnaire"
  And "I choose 'vůbec'"
  And "I fill in '10' for 'hodin'"
  And "I select '1' from 'sheet_purpose_relaxation'"
  And "I select '1' from 'sheet_purpose_hobbitry'"
  And "I select '1' from 'sheet_purpose_gathering'"
  And "I select '1' from 'sheet_purpose_fuel'"
  And "I fill in 'nahoře' for 'sheet_favorite_place'"
  And "I press 'Odeslat I. část'"
end
Given /^I fill in both parts of questionnaire$/ do
  Given "I filled first part of questionnaire"
  And "I fill in '10' for 'sheet_once_payment'"
  And "I fill in '10' for 'sheet_once_receive'"
  And "I select '1' from 'sheet_important_wood'"
  And "I select '1' from 'sheet_important_gathering'"
  And "I select '1' from 'sheet_important_water'"
  And "I select '1' from 'sheet_important_ground'"
  And "I select '1' from 'sheet_important_climate'"
  And "I select '1' from 'sheet_important_health'"
  And "I select '1' from 'sheet_important_nature'"
  And "I choose 'jsem student/studentka'"
  And "I press 'Odeslat II. část'"
end
Then /^I should see unique code$/ do
  regexp = Regexp.new(/\b[0-9a-f]{24}\b/)
  page.should have_xpath('//*', :text => regexp)
end
Then /^I should see '(.+)' and time$/ do |text|
  regexp = Regexp.new(/#{text} \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
  page.should have_xpath('//*', :text => regexp)
end
Then /^I should see '(.+)' followed by number$/ do |text|
  regexp = Regexp.new(/#{text} \d+/)
  page.should have_xpath('//*', :text => regexp)
end
When /^I follow unique code$/ do
  find(:css, 'li a').click 
end
Given /^I know 2 questionnaires were filled in$/ do
  Sheet.destroy_all
  2.times {Given "I fill in both parts of questionnaire"}
end
When /^I follow first sheet detail$/ do 
  find(:css, 'table.table td.first a').click
end
Given /^I know 2 questionnaires were just started$/ do
  2.times {Given "I filled first part of questionnaire"}
end
Then /^I should receive CSV file$/ do
  page.response_headers['Content-type'].should == 'text/csv;charset=utf-8'
end
Then /^file should have (\d+) lines$/ do |count|
  page.body.lines.to_a.size.should == count.to_i
end
Then /^line should have (\d+) items separated by '(.*)'$/ do |count, separator|
  page.body.lines.first.split(',').size.should == count.to_i
end
Then /^(\d+)\. item should be uniq code$/ do |order|
  regexp = Regexp.new(/\b[0-9a-f]{24}\b/)
  page.body.lines.first.split(',').first.should match(regexp)
end
Then /^(\d+)\. item should be date$/ do |order|
  regexp = Regexp.new(/\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}:\d{2} \+\d{4}/)
  page.body.lines.first.split(',')[order.to_i-1].should match regexp
end
Then /^(\d+)\. item should be number$/ do |order|
  regexp = Regexp.new(/\d*/)
  page.body.lines.first.split(',')[order.to_i-1].should match regexp
end

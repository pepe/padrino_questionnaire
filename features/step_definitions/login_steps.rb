Given /^I have admin '(.+)' with password '(.+)'$/ do |email, password|
  Account.find(:first, :conditions => {:email => email}) || Account.create(:email => email, :password => password, :password_confirmation => password, :name => 'God', :surname => 'Hides', :role => 'admin')
end

Given /^I logged in as admin$/ do
  Given "I have admin 'god@laststar.cz' with password 'hides'"
  And "I visit '/admin/session/new'"
  And "I fill in 'god@laststar.cz' for 'email'"
  And "I fill in 'hides' for 'password'"
  And "I press 'Sign In'"
end


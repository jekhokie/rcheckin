Given /^I am using a mobile device$/ do
  page.driver.header('user-agent', 'Mobile')
end

When /^I make a web request to access the RCheckin application$/ do
  visit '/'
end

Then /^I should be able to view the site in mobile format$/ do
  page.should     have_content("RCMobile")
  page.should_not have_content("RCheckin")
end

Given /^I am not using a mobile device$/ do
  page.driver.header('user-agent', 'Mozilla')
end

Then /^I should be able to view the site in non\-mobile format$/ do
  page.should     have_content("RCheckin")
  page.should_not have_content("RCMobile")
end

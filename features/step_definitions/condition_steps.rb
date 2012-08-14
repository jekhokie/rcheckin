Given /^a co\-user with the name "(.*?)" is currently (OUT|IN)$/ do |user_name, user_state|
  user = FactoryGirl.create(:user, name: user_name, :email => "test@test.com")

  condition = user.condition
  condition.state = (user_state == "IN" ? true : false)
  condition.save!
end

When /^I click "(.*?)" in the QuickStat tool$/ do |desired_state|
  within "#quick-stat" do
    click_button desired_state
  end
end

Then /^the QuickStat tool should report me as "(.*?)"$/ do |current_state|
  within "#quick-stat #button-container" do
    page.should     have_css "input[type='submit'][value='#{current_state}'].btn-#{current_state == 'I am IN' ? 'success' : 'danger'}"
    page.should_not have_css "input[type='submit'][value='#{current_state}'].btn-#{current_state == 'I am IN' ? 'danger'  : 'success'}"
  end
end

Then /^the QuickStat tool should have its "(.*?)" button disabled$/ do |state|
  within "#quick-stat" do
    find_button(state)['disabled'].should == true
  end
end

Then /^the Co\-Users tool should be visible$/ do
  find("#co-users").should_not be_nil
end

Then /^the Co\-Users tool should not list the user for the current session$/ do
  find("#co-users").should_not have_content(@user.name)
end

Then /^the Co\-Users tool should list "(.*?)" with an (IN|OUT) indicator star$/ do |user_name, user_state|
  find("#co-users table tr:has(td:contains('#{user_name}')) td.state").should have_css(".state-star-#{user_state.downcase}")
end

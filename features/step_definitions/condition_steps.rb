When /^I click "(.*?)" in the QuickStat tool$/ do |desired_state|
  within "#quick-stat" do
    click_button desired_state
  end
end

Then /^the QuickStat tool should report me as "(.*?)"$/ do |current_state|
  within "#quick-stat #button-container" do
    page.should     have_css "input[type='submit'][value='#{current_state}'].btn-#{current_state == 'IN' ? 'success' : 'danger'}"
    page.should_not have_css "input[type='submit'][value='#{current_state}'].btn-#{current_state == 'IN' ? 'danger'  : 'success'}"
  end
end

Then /^the QuickStat tool should have its "(.*?)" button disabled$/ do |state|
  within "#quick-stat" do
    find_button(state)['disabled'].should == true
  end
end

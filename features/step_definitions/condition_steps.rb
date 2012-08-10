When /^I click "(.*?)" in the QuickStat tool$/ do |desired_state|
  within "#quick-stat" do
    click_button desired_state
  end
end

Then /^the QuickStat tool should report me as "(.*?)"$/ do |current_state|
  within "#quick-stat #button-container" do
    page.should     have_css "button:contains('#{current_state}').btn-#{current_state == 'IN' ? 'success' : 'danger'}"
    page.should_not have_css "button:contains('#{current_state}').btn-#{current_state == 'IN' ? 'danger'  : 'success'}"
  end
end

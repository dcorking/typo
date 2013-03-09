When /^I drop admin privileges$/ do
  # Depends on a scenario which has user 1 logged in, such as merge_articles.feature
  # May be useful to generalize it for more complex multi-user scenarios
  # User 1 fixture defined in web_steps.rb "Given /^the blog is set up$/ do"
  user = User.find_by_id 1
  user.profile = Profile.find_by_label "contributor"
end

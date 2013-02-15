Given /^I am logged in as a non\-admin user$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I must not see a "(.*?)" field$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^a submission of the merge URI must be rejected$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I merge two articles$/ do
  Article.create!(:allow_comments => true, :allow_pings => false, :author => "AnAuthor", :body => "There was one article", :guid => "1bf3e2ca-ed7b-4562-8a4a-8ce8438822c9", :id => 2, :permalink => "article-one", :post_type => "read", :published => true, :published_at => "2012-06-09 21:51:55 UTC", :settings => {"password"=>nil}, :state => "published", :text_filter_id => 5, :title => "First article", :type => "Article", :user_id => 1)
  Article.create!(:allow_comments => true, :allow_pings => false, :author => "AnotherAuthor", :body => "There was another article", :guid => "1bf3e2ca-ed7b-4562-8a4a-8ce8438822ca", :id => 3, :permalink => "article-two", :post_type => "read", :published => true, :published_at => "2012-06-09 21:51:55 UTC", :settings => {"password"=>nil}, :state => "published", :text_filter_id => 5, :title => "Second article", :type => "Article", :user_id => 1)
end

Then /^the first article contains the text of both$/ do
  # this cheats and looks into the model instead of a view
  Article.find_by_title("First article").body.should match /one.*another/m 
end

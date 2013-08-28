Given /^I am logged in as a non\-admin user$/ do
  # User fixtures defined in web_steps.rb "Given /^the blog is set up$/ do"
  visit '/accounts/login'
  fill_in 'user_login', :with => 'eve'
  fill_in 'user_password', :with => 'secret'
  click_button 'Login'
  page.should have_content('Login successful')
end

Then /^a submission of the merge URI must be rejected$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the first article contains the text of both$/ do
  # this cheats and looks into the model instead of a view
  Article.find_by_title('First article').body.should include 'There was one article'
  Article.find_by_title('First article').body.should include 'There was another article'
end

When /^I create two unique articles$/ do
  # This isn't used in scenarios, so it should be extracted as a method.
  # It is used in 'When I merge two articles'
  @first_article = Article.create!(:allow_comments => true, :allow_pings => false, :author => "AnAuthor", :body => "There was one article", :permalink => "article-one", :post_type => "read", :published => true, :published_at => "2012-06-09 21:51:55 UTC", :settings => {"password"=>nil}, :state => "published", :text_filter_id => 5, :title => "First article", :type => "Article", :user_id => 1)
  @comment1 = Comment.create!({:author => 'Bob',
                                :article => @first_article,
                                :body => 'nice post',
                                :ip => '1.2.3.4'}) 
  @comment2 = Comment.create!({:author => 'Alice',
                                :article => @first_article,
                                :body => 'interesting',
                                :ip => '1.2.3.4'}) 
  @second_article = Article.create!(:allow_comments => true, :allow_pings => false, :author => "AnotherAuthor", :body => "There was another article",  :permalink => "article-two", :post_type => "read", :published => true, :published_at => "2012-06-09 21:51:55 UTC", :settings => {"password"=>nil}, :state => "published", :text_filter_id => 5, :title => "Second article", :type => "Article", :user_id => 1)
  @comment3 = Comment.create!({:author => 'Charlie',
                                :article => @second_article,
                                :body => 'me too',
                                :ip => '1.2.3.4'}) 
  @comment4 = Comment.create!({:author => 'Dierdre',
                                :article => @second_article,
                                :body => 'I recommend it',
                                :ip => '1.2.3.4'}) 
end

When /^I merge them into the first$/ do
  visit "admin/content/edit/#{@first_article.id}"
  fill_in('merge_with', :with => @second_article.id)
  click_button('Merge')
end

When /^I merge two articles$/ do
  #TODO factor out the steps into helper methods in support/world_extensions.rb
  steps %Q{
    When I create two unique articles
    And I merge them into the first}
end

Then /^the merged article has all the comments of the first article$/ do
  pending
end

Then /^the merged article has all the comments of the second article$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the merged article has the title of one of the predecessors$/ do
  pending
end

Then /^I don\'t see a merge form$/ do
  # a view has been retrieved
  page.should_not have_content 'Merge Articles'
end

Then /^the merged article has one author$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the "([^"]*)" field should have the name "([^"]*)"$/ do |field, attr|
# for autograding the merge ID field must have the attribute merge_with
  pending 'This finder is seemingly broken, though the Article ID field is implemented and named'
  find_field(field)['name'].should have_attribute(attr)
end

Then /^I request a merge with the same article$/ do
  fill_in 'merge_with', :with => @an_article.id
  click_button 'Merge'
end

Then /^the article\'s body is not duplicated$/ do
  visit '/admin/content'
  click_link @an_article.title
  expect(page.text).not_to include 'There was one articleThere was one article'
end

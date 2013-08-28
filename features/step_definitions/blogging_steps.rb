When /^I edit an article$/ do
  # depends on article 1 existing in the scenario, as used in merge_articles.feature
  # TODO factor this out to a helper method  in support/world_extensions.rb
  @an_article = Article.create!(:allow_comments => true, :allow_pings => false, :author => "AnAuthor", :body => "There was one article", :permalink => "article-one", :post_type => "read", :published => true, :published_at => "2012-06-09 21:51:55 UTC", :settings => {"password"=>nil}, :state => "published", :text_filter_id => 5, :title => "First article", :type => "Article", :user_id => 1)
  visit "/admin/content/edit/#{@an_article.id}"
end

When /^(?:|I) create a new article$/ do
  # TODO factor this out to a helper method in support/world_extensions.rb
  visit '/admin/content/new'
end

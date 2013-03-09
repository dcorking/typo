When /^I edit a[n] "(.*?)"$/ do
  # edit an article, comment etc
  # depends on article 1 existing in the scenario, as used in merge_articles.feature
  # TODO factor this out to a helper method  in support/world_extensions.rb
  if content = "article"
    visit '/admin/content/1/edit'
  else 
    pending # I don't need other content types yet
end

When /^I create a new "(.*?)"$/ do |content|
  # create a new article, comment etc
  # TODO factor this out to a helper method in support/world_extensions.rb
  if content = "article"
    visit '/admin/content/new'
  else 
    pending # I don't need other content types yet
  end
end

When /^I edit an article$/ do
  # depends on article 1 existing in the scenario, as used in merge_articles.feature
  # TODO factor this out to a helper method  in support/world_extensions.rb
  visit '/admin/content/edit/1'
end

When /^(?:|I) create a new article$/ do
  # TODO factor this out to a helper method in support/world_extensions.rb
  visit '/admin/content/new'
end

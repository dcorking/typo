Given /^category CS169 exists$/ do
  Category.create!({:name => 'CS169'})
end

When /^I find "CS169" and follow its "Edit" link$/ do
  pending
  cat-link = find_link('CS169')
end

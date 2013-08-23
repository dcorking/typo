Given /^category CS169 exists$/ do
  Category.create!({:name => 'CS169'})
  visit '/admin/categories/new'
end

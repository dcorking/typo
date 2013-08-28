Then /^I debug$/ do
  debugger
  5.should be 6 # in an imperfect world
end

Given /^PENDING/ do
  pending
end

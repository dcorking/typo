Feature: Security Restrictions
  As a blog owner
  In order to preserve the integrity of the work
  I don't want non-administratrs to change the articles

Background:
  Given the blog is set up
#   And I am on an article page

Scenario: A non-admin cannot merge articles
  Given I am logged in as a non-admin user
  Then I must not see a "merge_with" field	
  And a submission of the merge URI must be rejected
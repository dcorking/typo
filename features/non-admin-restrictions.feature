Feature: Security Restrictions
  As a blog owner
  In order to preserve the integrity of the work
  I don't want non-administratrs to change the articles

Background:
  Given the blog is set up
  And I am logged in as a non-admin user

Scenario: A non-admin does not see the merge form
  When I edit an article
  Then I don't see a merge form

Scenario: A non-admin cannot merge articles
  Then a submission of the merge URI must be rejected

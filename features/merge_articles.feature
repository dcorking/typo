Feature: Merge Articles
  As a blog administrator
  In order to make the most of my writing
  I want to be able to merge two articles 

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    When I merge two articles
    Then the first article contains the text of both

  Scenario: When articles are merged, the merged article should have one author 

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article

  Scenario: The title of the new article should be the title from either one of the merged articles.

  Scenario: The form field containing the ID of the article to merge with must have the HTML attribute name set to merge_with
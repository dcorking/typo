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
    When I merge two articles
    Then the merged article has one author

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article
    When I merge two articles
    Then the merged article has all the comments of the first article
    And the merged article has all the comments of the second article

  Scenario: The title of the new article should be the title from either one of the merged articles.
    When I merge two articles
    Then the merged article has the title of one of the predecessors

# For autograding
# The form field containing the ID of the article to merge with must have the HTML attribute name set to merge_with
  Scenario: The merge form contains an item named 'merge_with'
    When I edit an article
    Then the "Article ID" field should have the name "merge_with"

  Scenario: The merge interface should not be presented for new articles
    When I create a new article
    Then I don't see a merge form

  Scenario: Nothing will be merged when the id is the same as the current article
    When I edit an article
    And I request a merge with the same article
    Then the article's body is not duplicated

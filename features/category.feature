Feature: Create and edit categories
  As a blog administrator
  In order to allow readers to organise my thoughts by category
  I want to be able to create and edit categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And I follow "Categories"

  Scenario: Display categories view
    Then I should see "Categories"
    And I should see "Name"
    And I should see "Description"

  Scenario: Create a new category
    When I fill in "Name" with "Jelly"
    And I fill in "Keywords" with "dessert"
    And I fill in "Permalink" with "gel"
    And I fill in "Description" with "Gelatinous foods"
    And I press "Save"
    And I follow "Jelly"
    Then I should see "Gelatinous foods"

  Scenario: Edit a category
    Given category CS169 exists
    When I follow "CS169"
    And I fill in "Description" with "Fun and Saas"
    And I press "Save"
    Then I should see "Categories"
    And I follow "CS169"
    Then I should see "Fun and Saas"

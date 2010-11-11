Feature: Users are able to categorize Schedules with tags

Background:
  Given I am a new, authenticated user
    And I have no schedules


@javascript
Scenario: I can create a Schedule with tags
  Given I am on the new schedule page
   When I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
     | taggings         | foo bar baz |
    And I follow "(add item)"
    And I select "0" from "level" within the 1st ".item" fieldset
    And I fill in "text" with "200m" within the 1st ".item" fieldset
    And I press "Save"
   Then I should have 1 schedules
    And I should be on the schedule page
    And I should see "foo bar baz"


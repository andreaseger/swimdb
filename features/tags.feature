Feature: Users are able to categorize Schedules with tags

Background:
  Given I have no schedules


Scenario: I can see a TagCloud
  Given I have a schedule with following tags "foo bar baz"
    And I have a schedule with following tags "foo baz hase"
    And I have a schedule with following tags "hase banane baz"
   When I am on the homepage
   Then I should see "foo (2)"
    And I should see "bar (1)"
    And I should see "baz (3)"
    And I should see "hase (2)"


@javascript
Scenario: I can create a Schedule with tags
  Given I am on the new schedule page
   When I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
     | taggings         | foo bar baz |
    And I follow "(add item)"
    And I fill in "level" with "0" within the 1st ".item" fieldset
    And I fill in "text" with "200m" within the 1st ".item" fieldset
    And I press "Save"
   Then I should have 1 schedules
    And I should be on the schedule page
    And I should see "foo bar baz"


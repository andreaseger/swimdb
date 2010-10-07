Feature: It should be possible to view a list of Schedules and
  show, edit, create and delete a specific one


Scenario: There are no Schedules
  Given I have no Schedules
  When I am on the list of schedules
  Then I should see "Schedules"
   And I should see "New Schedule" within "a"

Scenario: There are some Schedules to list
  Given I have 2 Schedules "Foo" and "Bar"
   When I am on the list of schedules
   Then I should see "Schedules"
    And I should see "Foo"
    And I should see "Bar" within "ul/li/strong"

@javascript
Scenario: I can create a new Schedule with 2 Items
  Given I have no Schedules
    And I am on the new schedule page
   When I click on the "(add item)" link
    And I click on the "(add item)" link
    And I fill in the following:
     | Name             | Foobar      |
     | Description      | Lorem Ipsum |
    And I fill in "level" with "0" within the 1st ".item" fieldset
    And I fill in "text" with "400m" within the 1st ".item" fieldset
    And I fill in "rank" with "0" within the 1st ".item" fieldset
    And I fill in "level" with "0" within the 2nd ".item" fieldset
    And I fill in "text" with "200m" within the 2nd ".item" fieldset
    And I fill in "rank" with "1" within the 2nd ".item" fieldset
    And I press "Save"
   Then I should have 1 schedule
    And I should be on the schedule page
    And I should see "Foobar" within "strong"
    And I should see "Lorem Ipsum" within "p"
    And I should see "400m" within "ul/li"
    And I should see "200m" within "ul/li"


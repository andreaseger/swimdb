Feature: It should be possible to view a list of schedules and
  show, create and delete a specific one


Scenario: There are no schedules
  Given I have no schedules
  When I am on the list of schedules
  Then I should see "Schedules"
   And I should see "New Schedule" within "a"

Scenario: There are some schedules to list
  Given I have 2 schedules "Foo" and "Bar"
   When I am on the list of schedules
   Then I should see "Schedules"
    And I should see "Foo"
    And I should see "Bar" within "ul/li/strong"

@javascript
Scenario: I can create a new schedule with 2 Items
  Given I have no schedules
    And I am on the new schedule page
   When I follow "(add item)"
    And I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
    And I fill in "level" with "0" within the 1st ".item" fieldset
    And I fill in "text" with "400m" within the 1st ".item" fieldset
    And I follow "(add item)"
    And I fill in "level" with "0" within the 2nd ".item" fieldset
    And I fill in "text" with "200m" within the 2nd ".item" fieldset
    And I press "Save"
   Then I should have 1 schedules
    And I should be on the schedule page
    And I should see "Foobar" within "strong"
    And I should see "Lorem Ipsum" within "p"
    And I should see "400m" within "ul/li"
    And I should see "200m" within "ul/li"

@javascript
Scenario: I cannot create a new schedule with a invalid Item
  Given I have no schedules
    And I am on the new schedule page
   When I follow "(add item)"
    And I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
    And I fill in "level" with "0" within the 1st ".item" fieldset
    And I fill in "text" with "400m" within the 1st ".item" fieldset
    And I follow "(add item)"
    And I fill in "level" with "0" within the 2nd ".item" fieldset
    And I fill in "text" with "foo" within the 2nd ".item" fieldset
    And I press "Save"
   Then I should see "error"


@javascript
Scenario: I can delete a schedule
  Given I have no schedules
    And I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
    And I am on the schedule page
   When I click destroy
   Then I should have 0 schedules
    And I should be on the list of schedules


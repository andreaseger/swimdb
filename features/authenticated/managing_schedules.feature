Feature: If the user is logged in he should have all options to manage schedules
  In order to manage the accounts
  As an logged in user
  I want to be able to manage all schedules

Background:
  Given I am a new, authenticated user
    And I have no schedules

Scenario: There are no schedules
  Given I am on the list of schedules
   Then I should see "Schedules"
    And I should see "New Schedule"

Scenario: There are some schedules to list
  Given I have 2 schedules "Foo" and "Bar"
   When I am on the list of schedules
   Then I should see "Schedules"
    And I should see "Foo"
    And I should see "Bar"
    And I should see "New Schedule"

@javascript
Scenario: I can create a new schedule with 2 Items
  Given I am on the new schedule page
   When I follow "(add item)"
    And I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
     | taggings         | foo bar     |
    And I select "0" from "level" within the 1st ".item" fieldset
    And I fill in "text" with "400m" within the 1st ".item" fieldset
    And I follow "(add item)"
    And I select "0" from "level" within the 2nd ".item" fieldset
    And I fill in "text" with "200m" within the 2nd ".item" fieldset
    And I press "Save"
   Then I should have 1 schedules
    And I should be on the schedule page
    And I should see "Foobar"
    And I should see "Lorem Ipsum"
    And I should see "400m"
    And I should see "200m"

@javascript
Scenario: I cannot create a new schedule with a invalid Item
  Given I am on the new schedule page
   When I follow "(add item)"
    And I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
     | taggings         | foo bar     |
    And I select "0" from "level" within the 1st ".item" fieldset
    And I fill in "text" with "400m" within the 1st ".item" fieldset
    And I follow "(add item)"
    And I select "0" from "level" within the 2nd ".item" fieldset
    And I fill in "text" with "foo" within the 2nd ".item" fieldset
    And I press "Save"
   Then I should see "error"

@javascript
Scenario: I can delete a schedule
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
    And I am on the schedule page
   When I click "Destroy"
   Then I should have 0 schedules
    And I should be on the list of schedules

@javascript
Scenario: I can edit an existing schedule
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      |
      | 0     | 400m      |
      | 0     | 3*200m    |
      | 0     | 4*200m    |
      | 1     | 2*100m    |
      | 2     | 50m       |
      | 0     | 400m      |
    And I am on the schedule page
   When I follow "Edit" within "#schedule"
    And I fill in "name" with "Hello World"
    And I follow "(remove)" within the 5th ".item" fieldset
    And I fill in "text" with "700m" within the 5th ".item" fieldset
    And I press "Save"
   Then I should be on the schedule page
    And I should see "Hello World" within "h2"
    And I should see "700m"
    And I should not see "50m"

Scenario: I will be getting an error when entering something invalid on edit
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      |
      | 0     | 400m      |
      | 0     | 3*200m    |
    And I am on the schedule page
   When I follow "Edit" within "#schedule"
    And I fill in "name" with ""
    And I press "Save"
   Then I should see "error"

@allow_rescue
@javascript
Scenario: I will be getting an error when entering an invalid item on edit
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      |
      | 0     | 400m      |
      | 0     | 3*200m    |
      | 0     | 4*200m    |
      | 1     | 2*100m    |
      | 2     | 50m       |
      | 0     | 400m      |
    And I am on the schedule page
   When I follow "Edit" within "#schedule"
    And I fill in "text" with "foobar" within the 3nd ".item" fieldset
    And I press "Save"
   Then I should see "error"


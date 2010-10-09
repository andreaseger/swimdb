Feature: Editing Schedules and their nested items

@javascript
Scenario: I can edit an existing schedule
  Given I have no schedules
    And I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
      | 0     | 3*200m    | 1    |
      | 0     | 4*200m    | 2    |
      | 1     | 2*100m    | 3    |
      | 2     | 50m       | 4    |
      | 0     | 400m      | 5    |
    And I am on the schedule page
   When I follow "Edit"
    And I fill in "name" with "Hello World"
    And I follow "(remove)" within the 5th ".item" fieldset
    And I fill in "text" with "100m" within the 5th ".item" fieldset
    And I press "Save"
   Then I should be on the schedule page
    And I should see "Hello World" within "strong"
    And I should not see "50m"

Scenario: I will be getting an error when entering something invalid on edit
  Given I have no schedules
    And I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
      | 0     | 3*200m    | 1    |
    And I am on the schedule page
   When I follow "Edit"
    And I fill in "name" with ""
    And I press "Save"
   Then I should see "error"

@javascript
Scenario: I will be getting an error when entering an invalid item on edit
  Given I have no schedules
    And I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
      | 0     | 3*200m    | 1    |
      | 0     | 4*200m    | 2    |
      | 1     | 2*100m    | 3    |
      | 2     | 50m       | 4    |
      | 0     | 400m      | 5    |
    And I am on the schedule page
   When I follow "Edit"
    And I fill in "text" with "foobar" within the 3nd ".item" fieldset
    And I press "Save"
   Then I should see "error"


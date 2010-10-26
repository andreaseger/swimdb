Feature: If the user is not logged in he can only see a list of schedules and thier details
  In order to protect the other people from spam
  As a guest
  I want to let them only see the Schedules

Background:
  Given I am not authenticated
    And I have no schedules

Scenario: There are no schedules
   When I am on the list of schedules
   Then I should see "Schedules"
    And I should not see "New Schedule"

Scenario: There are some schedules to list
  Given I have 2 schedules "Foo" and "Bar"
   When I am on the list of schedules
   Then I should see "Schedules"
    And I should see "Foo"
    And I should see "Bar"
    And I should not see "New Schedule"

@allow_rescue
Scenario: I am not able to create a schedule
  Given I am on the home page
   When I go to the new schedule page
   Then I should see "You need to sign in or sign up before continuing."

Scenario: I dont see the destroy link
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
   When I am on the schedule page
   Then I should not see "Destroy"

#@allow_rescue
#Scenario: I am not able to delete a schedule
#  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
#      | level | text      | rank |
#      | 0     | 400m      | 0    |
#    And I am on the schedule page
#   When I go to the destroy schedule page
#   Then I should see "You need to sign in or sign up before continuing."

Scenario: I dont see the edit link
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
   When I am on the schedule page
   Then I should not see "Edit"

@allow_rescue
Scenario: I am not able to edit an existing schedule
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
    And I am on the schedule page
   When I go to the edit schedule page
   Then I should see "You need to sign in or sign up before continuing."


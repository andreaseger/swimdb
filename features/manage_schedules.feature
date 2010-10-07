Feature: It should be possible to view a list of Schedules and
  show, edit, create and delete a specific one


Scenario: There are no Schedules
  Given I have no Schedules
  When I am on the list of schedules
  Then I should see "Schedules"
   And I should see "New Schedule" within "a"

Scenario: There are some Schedules
  Given I have 2 Schedules "Foo" and "Bar"
  When I am on the list of schedules
  Then I should see "Schedules"
   And I should see "Foo"
   And I should see "Bar" within "ul/li/strong"


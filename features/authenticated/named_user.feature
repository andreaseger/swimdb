Feature: just need a featureset where i know the name of the User

Background:
 Given I am a new, authenticated user named "Bob"


@javascript
Scenario: The schedule gets linked to the user while creation
  Given I am on the new schedule page
   When I follow "(add item)"
    And I fill in the following:
     | name             | Foobar      |
     | description      | Lorem Ipsum |
    And I fill in "level" with "0" within the 1st ".item" fieldset
    And I fill in "text" with "400m" within the 1st ".item" fieldset
    And I press "Save"
   Then I should have 1 schedules
    And the schedules user should be "Bob"


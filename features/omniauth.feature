@manual
Feature: Allow Users to use their existing facebook & twitter account to login

Scenario: Add an twitter account to an existing user
  Given I am a new, authenticated user
    And I am on the list of authentications
   When I follow twitter (manualstep)
   Then I should be on the homepage
    And I should see "added the twitter account to your account"

Scenario: Create a new user direclty with a twitter account
  Given I am not authenticated
    And I am on the homepage
   When I follow "Login or SignUp"
    And I follow twitter (manualstep)
   Then I should be on the new users page

Scenario: Create a user with facebook on the fly
  Given I am not authenticated
    And I am on the homepage
   When I follow "Login or SignUp"
    And I follow facebook (manualstep)
   Then I should be on the homepage
    And I should be logged in
    And I should have a user with "facebook" authentication


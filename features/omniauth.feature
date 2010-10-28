Feature: Allow Users to use their existing facebook & twitter account to login

@manual
Scenario: Add an twitter account to an existing user
  Given I am a new, authenticated user
    And I am on the list of authentications
   When I follow twitter (manualstep)
   Then I should be on the homepage
    And I should see "added the twitter account to your account"

@manual
Scenario: Create a new user direclty with a twitter account
  Given I am not authenticated
    And I am on the homepage
   When I follow "Login or SignUp"
    And I follow twitter (manualstep)
   Then I should be on the new users page

@manual
Scenario: Create a user with facebook on the fly
  Given I am not authenticated
    And I am on the homepage
   When I follow "Login or SignUp"
    And I follow facebook (manualstep)
   Then I should be on the homepage
    And I should be logged in
    And I should have a user with "facebook" authentication

Scenario: Create a omniauth user - - steptest
  Given I am a new, authenticated omniauth user
   Then I should have a user with "dummy" authentication
    And I should have 1 Users
    And I should have 1 Authenications

@javascript
Scenario: Delete a User should also delete its authentications
  Given I am a new, authenticated omniauth user
    And I am on the homepage
   When I follow "Edit Profile"
    And I follow "Edit Details"
    And I click "Cancel my account"
   Then I should have 0 Users
    And I should have 0 Authenications


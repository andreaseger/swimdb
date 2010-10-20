Feature: Users are able to login via there twitter accout
  In Order to give users a easy way to access the site
    I Want them to be able to use there existing twitter account to register an login

Scenario: Add an twitter account to an existing user
  Given I am a new, authenticated user
    And I am on the list of authentications
   When I follow "twitter"
    And I allow the app(manual step)
   Then I should be on the list of authentications
    And I should see "added the twitter account to your account"

Scenario: Create a new user direclty with a twitter account
  Given I am not authenticated
    And I am on the homepage
   When I follow "SignUp"
    And I follow "twitter"
    And I allow the app(manual step)
   Then I should be on the new users page


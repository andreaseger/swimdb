Feature: Should be able to register, login and logout
  In order ...
  I want ...

Scenario: Creating a new User
  Given I am not authenticated
    And I am on the homepage
   When I follow "SignUp"
    And I fill in "Tester" for "user_username"
    And I fill in "tester@email.com" for "user_email"
    And I fill in "secret" for "user_password"
    And I fill in "secret" for "user_password_confirmation"
    And I press "Sign up"
   Then I should see "You have signed up successfully"

Scenario: Login an existing user
  Given I am not authenticated
    And I have one user "tester@email.com" with password "secret" and username "Tester"
    And I am on the homepage
   When I follow "Login"
    And I fill in "Tester" for "user_username"
    And I fill in "secret" for "user_password"
    And I press "Sign in"
   Then I should see "Signed in successfully."


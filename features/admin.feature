Feature:As Admin you are able to edit all Schedule, User and Comments
  In Order to manage the page
      As a Admin
    I want to be able to access, edit and delete all schedules, comments and users

Scenario: I want to be able to see the special admin links
  Given I am a new, authenticated admin
   When I am on the homepage
   Then I should see "Logout Admin"
    And I should see "Admin Area"


Scenario: I want so see the admin area
  Given I am a new, authenticated admin
   When I am on the homepage
    And I follow "Admin Area"
   Then I should be on the admin area
    And I should see "Users List"

Scenario: I can edit a user
  Given I have one user "Bob"
    And I am a new, authenticated admin
    And I am on the admin area
    And I follow "Edit Bob"
   When I fill in "user_username" with "Alice"
    And I press "Save User"
   Then I should have a user named "Alice"


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
    And I follow "Bob"
    And I follow "Edit User"
   When I fill in "user_username" with "Alice"
    And I press "Save User"
   Then I should have a user named "Alice"

@javascript
Scenario: Admins can delete random comments
  Given I am a new, authenticated user
    And I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |
    And The schedule has no comments
    And I am on the schedule page
    And I fill in "comment_body" with "Lorem Ipsum"
    And I press "Post Comment"
    And I am not authenticated
    And I am a new, authenticated admin
   When I am on the schedule page
    And I click "Destroy" within ".comment"
   Then The schedule should have no comments


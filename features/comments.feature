Feature: Allow viewers to give feedback about existing schedules

Background:
  Given I have a schedule "Foobar" with the description "Lorem Ipsum" and the following items:
      | level | text      | rank |
      | 0     | 400m      | 0    |

@javascript
Scenario: As guest you can create comments by entering a Name and an email
  Given I am not authenticated
    And The schedule has no comments
    And I am on the schedule page
   When I fill in "comment_commenter" with "Hase"
    And I fill in "comment_email" with "hase@hase.com"
    And I fill in "comment_body" with "Lorem Ipsum"
    And I press "Post Comment"
   Then I should see "Comment was successfully created."
    And I should see "Lorem Ipsum"
    And I should see "Hase"

@javascript
Scenario: As guest you can create comments by entering a Name
  Given I am not authenticated
    And The schedule has no comments
    And I am on the schedule page
   When I fill in "comment_commenter" with "Hase"
    And I fill in "comment_body" with "Lorem Ipsum"
    And I press "Post Comment"
   Then I should see "Comment was successfully created."
    And I should see "Hase"
    And I should see "Lorem Ipsum"


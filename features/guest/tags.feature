Feature: Guests can see a TagCloud on the homepage

Background:
  Given I have no schedules

Scenario: I can see a TagCloud
  Given I have a schedule with following tags "foo bar baz"
    And I have a schedule with following tags "foo baz hase"
    And I have a schedule with following tags "hase banane baz"
   When I am on the homepage
   Then I should see "foo"
    And I should see "bar"
    And I should see "baz"
    And I should see "hase"


Feature: Users should be able to search in the list of schedules by tag

Background:
   Given I have a schedule "aaaa" with the following tags "foo sp baz"
     And I have a schedule "bbbb" with the following tags "ga1 bar baz"
     And I have a schedule "cccc" with the following tags "kt sp foo"
     And I have a schedule "dddd" with the following tags "Ga2 ga3 baz"

Scenario Outline: searching by tag
   Given I am on the list of schedules
    When I follow "<tag>" within "#tag_cloud"
    Then I should see "<possitive>"
     And I should not see "<negative>"

    Examples:
    |  tag   |  possitive | negative |
    |  foo   |  aaaa      |  bbbb    |
    |  bar   |  bbbb      |  cccc    |
    |  baz   |  dddd      |  cccc    |
    |  kt    |  cccc      |  aaaa    |
    |  sp    |  aaaa      |  dddd    |

Scenario: By clicking on show all it will show all schedules again
  Given I am on the list of schedules
    And I follow "foo" within "#tag_cloud"
   When I follow "Show all" within "#tag_cloud"
   Then I should be on the list of schedules
    And I should see "aaaa"
    And I should see "bbbb"
    And I should see "cccc"
    And I should see "dddd"


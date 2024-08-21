Feature: park another contribution branch

  Background:
    Given a Git repo with origin
    And the branch
      | NAME         | TYPE         | PARENT | LOCATIONS     |
      | contribution | contribution | main   | local, origin |
    When I run "git-town park contribution"

  Scenario: result
    Then it runs no commands
    And it prints:
      """
      branch "contribution" is now parked
      """
    And the parked branches are now "contribution"
    And there are now no contribution branches

  Scenario: undo
    When I run "git-town undo"
    Then it runs no commands
    And the contribution branches are now "contribution"
    And there are now no parked branches

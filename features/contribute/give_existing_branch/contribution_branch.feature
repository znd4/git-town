Feature: make another contribution branch a contribution branch

  Background:
    Given a Git repo with origin
    And the branches
      | NAME         | TYPE         | PARENT | LOCATIONS     |
      | contribution | contribution | main   | local, origin |
    When I run "git-town contribute contribution"

  Scenario: result
    Then Git Town runs no commands
    And Git Town prints the error:
      """
      branch "contribution" is already a contribution branch
      """
    And the contribution branches are still "contribution"

  Scenario: undo
    When I run "git-town undo"
    Then Git Town runs no commands
    And the contribution branches are still "contribution"

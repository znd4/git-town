Feature: prototype another prototype branch

  Background:
    Given a Git repo with origin
    And the branch
      | NAME      | TYPE      | PARENT | LOCATIONS     |
      | prototype | prototype | main   | local, origin |
    And the current branch is "prototype"
    When I run "git-town prototype prototype"

  Scenario: result
    Then it runs no commands
    And it prints the error:
      """
      branch "prototype" is already a prototype branch
      """
    And the prototype branches are now "prototype"
    And the current branch is still "prototype"

  Scenario: undo
    When I run "git-town undo"
    Then it runs no commands
    And the prototype branches are now "prototype"
    And the current branch is still "prototype"
    And the initial branches and lineage exist

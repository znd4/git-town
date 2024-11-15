@skipWindows
Feature: no "origin" remote

  Background:
    Given a local Git repo
    And the branches
      | NAME    | TYPE    | PARENT | LOCATIONS |
      | feature | feature | main   | local     |
    And tool "open" is installed
    And the current branch is "feature"
    And an additional "upstream" remote with URL "git@github.com:git-town/git-town.git"
    When I run "git-town propose"

  @debug
  @this
  Scenario: result
    Then Git Town runs the commands
      | BRANCH  | COMMAND                                            |
      | feature | git fetch --prune --tags                           |
      |         | git merge --no-edit --ff main                      |
      |         | git push -u origin feature                         |
      | <none>  | Looking for proposal online ... ok                 |
      |         | open https://github.com/git-town/git-town/pull/123 |
    And the current branch is still "feature"
    And the initial branches and lineage exist now

  Scenario: undo
    When I run "git-town undo"
    Then Git Town runs no commands
    And the current branch is still "feature"
    And the initial commits exist now

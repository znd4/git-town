Feature: auto-push the new branch

  Background:
    Given a Git repo with origin
    And Git Town setting "push-new-branches" is "true"
    And the commits
      | BRANCH | LOCATION | MESSAGE       |
      | main   | origin   | origin commit |
    And the current branch is "main"
    And an uncommitted file
    When I run "git-town hack new"

  Scenario: result
    Then Git Town runs the commands
      | BRANCH | COMMAND                |
      | main   | git add -A             |
      |        | git stash              |
      |        | git checkout -b new    |
      | new    | git push -u origin new |
      |        | git stash pop          |
    And the current branch is now "new"
    And the initial commits exist now
    And this lineage exists now
      | BRANCH | PARENT |
      | new    | main   |
    And the uncommitted file still exists

  Scenario: undo
    When I run "git-town undo"
    Then Git Town runs the commands
      | BRANCH | COMMAND              |
      | new    | git add -A           |
      |        | git stash            |
      |        | git checkout main    |
      | main   | git branch -D new    |
      |        | git push origin :new |
      |        | git stash pop        |
    And the current branch is now "main"
    And the initial commits exist now
    And the initial branches and lineage exist now
    And the uncommitted file still exists

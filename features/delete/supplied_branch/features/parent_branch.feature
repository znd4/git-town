Feature: delete a parent branch

  Background:
    Given a Git repo with origin
    And the branches
      | NAME  | TYPE    | PARENT | LOCATIONS     |
      | alpha | feature | main   | local, origin |
    And the commits
      | BRANCH | LOCATION      | MESSAGE      |
      | alpha  | local, origin | alpha commit |
    And the branches
      | NAME | TYPE    | PARENT | LOCATIONS     |
      | beta | feature | alpha  | local, origin |
    And the commits
      | BRANCH | LOCATION      | MESSAGE     |
      | beta   | local, origin | beta commit |
    And the branches
      | NAME  | TYPE    | PARENT | LOCATIONS     |
      | gamma | feature | beta   | local, origin |
    And the commits
      | BRANCH | LOCATION      | MESSAGE      |
      | gamma  | local, origin | gamma commit |
    And the current branch is "gamma"
    And an uncommitted file
    When I run "git-town delete beta"

  Scenario: result
    Then Git Town runs the commands
      | BRANCH | COMMAND                  |
      | gamma  | git fetch --prune --tags |
      |        | git add -A               |
      |        | git stash                |
      |        | git push origin :beta    |
      |        | git branch -D beta       |
      |        | git stash pop            |
    And the current branch is now "gamma"
    And the uncommitted file still exists
    And the branches are now
      | REPOSITORY    | BRANCHES           |
      | local, origin | main, alpha, gamma |
    And these commits exist now
      | BRANCH | LOCATION      | MESSAGE      |
      | alpha  | local, origin | alpha commit |
      | gamma  | local         | gamma commit |
      |        | origin        | beta commit  |
      |        |               | gamma commit |
    And this lineage exists now
      | BRANCH | PARENT |
      | alpha  | main   |
      | gamma  | alpha  |

  Scenario: undo
    When I run "git-town undo"
    Then Git Town runs the commands
      | BRANCH | COMMAND                                   |
      | gamma  | git add -A                                |
      |        | git stash                                 |
      |        | git branch beta {{ sha 'beta commit' }}   |
      |        | git push -u origin beta                   |
      |        | git reset --hard {{ sha 'gamma commit' }} |
      |        | git stash pop                             |
    And the current branch is now "gamma"
    And the uncommitted file still exists
    And the initial commits exist now
    And the initial branches and lineage exist now

Feature: merging a branch with disabled push-hook

  Background:
    Given a Git repo with origin
    And the branches
      | NAME  | TYPE    | PARENT | LOCATIONS     |
      | alpha | feature | main   | local, origin |
      | beta  | feature | alpha  | local, origin |
    And the commits
      | BRANCH | LOCATION      | MESSAGE      |
      | alpha  | local, origin | alpha commit |
      | beta   | local, origin | beta commit  |
    And the current branch is "beta"
    And Git Town setting "push-hook" is "false"
    When I run "git-town merge"

  Scenario: result
    Then Git Town runs the commands
      | BRANCH | COMMAND                               |
      | beta   | git fetch --prune --tags              |
      |        | git checkout alpha                    |
      | alpha  | git merge --no-edit --ff origin/alpha |
      |        | git checkout beta                     |
      | beta   | git merge --no-edit --ff alpha        |
      |        | git merge --no-edit --ff origin/beta  |
      |        | git push --no-verify                  |
      |        | git branch -D alpha                   |
      |        | git push origin :alpha                |
    And the current branch is still "beta"
    And this lineage exists now
      | BRANCH | PARENT |
      | beta   | main   |
    And these commits exist now
      | BRANCH | LOCATION      | MESSAGE                        |
      | beta   | local, origin | beta commit                    |
      |        |               | alpha commit                   |
      |        |               | Merge branch 'alpha' into beta |

  Scenario: undo
    When I run "git-town undo"
    Then Git Town runs the commands
      | BRANCH | COMMAND                                                     |
      | beta   | git reset --hard {{ sha-before-run 'beta commit' }}         |
      |        | git push --force-with-lease --force-if-includes --no-verify |
      |        | git branch alpha {{ sha-before-run 'alpha commit' }}        |
      |        | git push --no-verify -u origin alpha                        |
    And the current branch is still "beta"
    And the initial commits exist now
    And the initial lineage exists now
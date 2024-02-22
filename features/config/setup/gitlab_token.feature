Feature: enter the GitLab API token

  Scenario: auto-detected GitLab platform
    Given my repo's "origin" remote is "git@gitlab.com:git-town/git-town.git"
    When I run "git-town config setup" and enter into the dialog:
      | DIALOG                      | KEYS              | DESCRIPTION                                 |
      | welcome                     | enter             |                                             |
      | aliases                     | enter             |                                             |
      | main development branch     | enter             |                                             |
      | perennial branches          |                   | no input here since the dialog doesn't show |
      | perennial regex             | enter             |                                             |
      | hosting platform            | enter             |                                             |
      | gitlab token                | 1 2 3 4 5 6 enter |                                             |
      | origin hostname             | enter             |                                             |
      | sync-feature-strategy       | enter             |                                             |
      | sync-perennial-strategy     | enter             |                                             |
      | sync-upstream               | enter             |                                             |
      | push-new-branches           | enter             |                                             |
      | push-hook                   | enter             |                                             |
      | ship-delete-tracking-branch | enter             |                                             |
      | sync-before-ship            | enter             |                                             |
      | save config to Git metadata | down enter        |                                             |
    Then it runs the commands
      | COMMAND                                 |
      | git config git-town.gitlab-token 123456 |
    And local Git Town setting "hosting-platform" still doesn't exist
    And local Git Town setting "gitlab-token" is now "123456"

  Scenario: select GitLab manually
    When I run "git-town config setup" and enter into the dialog:
      | DIALOG                      | KEYS              | DESCRIPTION                                 |
      | welcome                     | enter             |                                             |
      | aliases                     | enter             |                                             |
      | main development branch     | enter             |                                             |
      | perennial branches          |                   | no input here since the dialog doesn't show |
      | perennial regex             | enter             |                                             |
      | hosting platform            | up enter          |                                             |
      | gitlab token                | 1 2 3 4 5 6 enter |                                             |
      | origin hostname             | enter             |                                             |
      | sync-feature-strategy       | enter             |                                             |
      | sync-perennial-strategy     | enter             |                                             |
      | sync-upstream               | enter             |                                             |
      | push-new-branches           | enter             |                                             |
      | push-hook                   | enter             |                                             |
      | ship-delete-tracking-branch | enter             |                                             |
      | sync-before-ship            | enter             |                                             |
      | save config to Git metadata | down enter        |                                             |
    Then it runs the commands
      | COMMAND                                     |
      | git config git-town.gitlab-token 123456     |
      | git config git-town.hosting-platform gitlab |
    And local Git Town setting "hosting-platform" is now "gitlab"
    And local Git Town setting "gitlab-token" is now "123456"

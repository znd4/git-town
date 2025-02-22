Feature: get Github API token from a script

  Background:
    Given a Git repo with origin

  Scenario: auto-detected GitHub platform
    Given my repo's "origin" remote is "git@github.com:git-town/git-town.git"
    When I run "git-town config setup" and enter into the dialog:
      | DIALOG                        | KEYS                    | DESCRIPTION                                 |
      | welcome                       | enter                   |                                             |
      | aliases                       | enter                   |                                             |
      | main branch                   | enter                   |                                             |
      | perennial branches            |                         | no input here since the dialog doesn't show |
      | perennial regex               | enter                   |                                             |
      | feature regex                 | enter                   |                                             |
      | default branch type           | enter                   |                                             |
      | hosting platform: auto-detect | enter                   |                                             |
      | github token                  | enter                   |                                             |
      | github token script           | e c h o space h i enter |                                             |
      | sync-feature-strategy         | enter                   |                                             |
      | sync-perennial-strategy       | enter                   |                                             |
      | sync-upstream                 | enter                   |                                             |
      | sync-tags                     | enter                   |                                             |
      | push-new-branches             | enter                   |                                             |
      | push-hook                     | enter                   |                                             |
      | create-prototype-branches     | down enter              |                                             |
      | ship-strategy                 | enter                   |                                             |
      | ship-delete-tracking-branch   | enter                   |                                             |
      | save config to Git metadata   | down enter              |                                             |
    Then Git Town runs the commands
      | COMMAND                                               |
      | git config git-town.github-token-script "echo hi" |
    And local Git Town setting "hosting-platform" still doesn't exist
    And local Git Town setting "github-token-script" is now "echo hi"

  Scenario: manually selected GitHub
    When I run "git-town config setup" and enter into the dialog:
      | DIALOG                      | KEYS                    | DESCRIPTION                                 |
      | welcome                     | enter                   |                                             |
      | aliases                     | enter                   |                                             |
      | main branch                 | enter                   |                                             |
      | perennial branches          |                         | no input here since the dialog doesn't show |
      | perennial regex             | enter                   |                                             |
      | default branch type         | enter                   |                                             |
      | feature regex               | enter                   |                                             |
      | hosting platform            | down down down enter    |                                             |
      | github token                | enter                   |                                             |
      | github token script         | e c h o space h i enter |                                             |
      | origin hostname             | enter                   |                                             |
      | sync-feature-strategy       | enter                   |                                             |
      | sync-perennial-strategy     | enter                   |                                             |
      | sync-upstream               | enter                   |                                             |
      | sync-tags                   | enter                   |                                             |
      | push-new-branches           | enter                   |                                             |
      | push-hook                   | enter                   |                                             |
      | create-prototype-branches   | enter                   |                                             |
      | ship-strategy               | enter                   |                                             |
      | ship-delete-tracking-branch | enter                   |                                             |
      | save config to Git metadata | down enter              |                                             |
    Then Git Town runs the commands
      | COMMAND                                               |
      | git config git-town.github-token-script "echo hi" |
      | git config git-town.hosting-platform github           |
    And local Git Town setting "hosting-platform" is now "github"
    And local Git Town setting "github-token-script" is now "echo hi"

  # TODO: Add github token script to this one
  Scenario: remove GitHub token script
    Given my repo's "origin" remote is "git@github.com:git-town/git-town.git"
    And local Git Town setting "github-token-script" is "ls"
    When I run "git-town config setup" and enter into the dialog:
      | DIALOG                        | KEYS                                | DESCRIPTION                                 |
      | welcome                       | enter                               |                                             |
      | aliases                       | enter                               |                                             |
      | main branch                   | enter                               |                                             |
      | perennial branches            |                                     | no input here since the dialog doesn't show |
      | perennial regex               | enter                               |                                             |
      | default branch type           | enter                               |                                             |
      | feature regex                 | enter                               |                                             |
      | hosting platform: auto-detect | enter                               |                                             |
      | github token                  | enter                               |                                             |
      | github token                  | backspace backspace enter           |                                             |
      | origin hostname               | enter                               |                                             |
      | sync-feature-strategy         | enter                               |                                             |
      | sync-perennial-strategy       | enter                               |                                             |
      | sync-upstream                 | enter                               |                                             |
      | sync-tags                     | enter                               |                                             |
      | push-new-branches             | enter                               |                                             |
      | push-hook                     | enter                               |                                             |
      | create-prototype-branches     | enter                               |                                             |
      | ship-strategy                 | enter                               |                                             |
      | ship-delete-tracking-branch   | enter                               |                                             |
      | save config to Git metadata   | down enter                          |                                             |
    Then Git Town runs the commands
      | COMMAND                                         |
      | git config --unset git-town.github-token-script |
    And local Git Town setting "hosting-platform" still doesn't exist
    And local Git Town setting "github-token-script" now doesn't exist

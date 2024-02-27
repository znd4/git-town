Feature: ask for missing configuration information

  Scenario: unconfigured
    Given Git Town is not configured
    When I run "git-town ship" and enter into the dialog:
      | DIALOG                  | KEYS  |
      | main development branch | enter |
    And the main branch is now "main"
    And it prints the error:
      """
      cannot ship the main branch
      """

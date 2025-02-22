package dialog

import (
	"fmt"

	"github.com/git-town/git-town/v16/internal/cli/dialog/components"
	"github.com/git-town/git-town/v16/internal/config/configdomain"
	"github.com/git-town/git-town/v16/internal/messages"
	. "github.com/git-town/git-town/v16/pkg/prelude"
)

const (
	githubTokenScriptTitle = `GitHub API token script`
	githubTokenScriptHelp  = `
Git Town can update pull requests and ship branches on GitHub for you.
To enable this, please enter a GitHub API token script.
More info at https://www.git-town.com/preferences/github-token.

If you leave this empty, Git Town will not use the GitHub API.

`
)

// GitHubTokenScript lets the user enter a script to get their GitHub API token.
func GitHubTokenScript(oldValue Option[configdomain.GitHubToken], inputs components.TestInput) (Option[configdomain.GitHubTokenScript], bool, error) {
	text, aborted, err := components.TextField(components.TextFieldArgs{
		ExistingValue: oldValue.String(),
		Help:          githubTokenScriptHelp,
		Prompt:        "Script to retrieve your Github API Token: ",
		TestInput:     inputs,
		Title:         githubTokenTitle,
	})
	fmt.Printf(messages.GitHubToken, components.FormattedSecret(text, aborted))
	return configdomain.ParseGitHubTokenScript(text), aborted, err
}

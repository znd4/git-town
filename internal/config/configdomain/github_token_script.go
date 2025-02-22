package configdomain

import (
	"strings"

	. "github.com/git-town/git-town/v16/pkg/prelude"
)

// GitHubTokenScript is a shell script to retrieve a GitHubToken.
type GitHubTokenScript string

func (self GitHubTokenScript) String() string {
	return string(self)
}

func ParseGitHubTokenScript(value string) Option[GitHubTokenScript] {
	value = strings.TrimSpace(value)
	if value == "" {
		return None[GitHubTokenScript]()
	}
	return Some(GitHubTokenScript(value))
}

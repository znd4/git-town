package gitdomain

import (
	"slices"

	. "github.com/git-town/git-town/v16/pkg/prelude"
)

// Remotes answers questions which Git remotes a repo has.
type Remotes []Remote

func NewRemotes(remotes ...string) Remotes {
	result := make(Remotes, len(remotes))
	for r, remote := range remotes {
		result[r] = NewRemote(remote)
	}
	return result
}

func (self Remotes) HasOrigin() bool {
	return slices.Contains(self, RemoteOrigin)
}

func (self Remotes) HasUpstream() bool {
	return slices.Contains(self, RemoteUpstream)
}

func (self Remotes) FirstUsableRemote() Option[Remote] {
	if self.HasOrigin() {
		return Some(RemoteOrigin)
	}
	if self.HasUpstream() {
		return Some(RemoteUpstream)
	}
	if len(self) > 0 {
		return Some(self[0])
	}
	return None[Remote]()
}

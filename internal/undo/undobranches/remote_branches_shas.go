package undobranches

import (
	"github.com/git-town/git-town/v15/internal/git/gitdomain"
	"golang.org/x/exp/maps"
)

type RemoteBranchesSHAs map[gitdomain.RemoteBranchName]gitdomain.SHA

// BranchNames provides the names of the involved branches as strings.
func (self RemoteBranchesSHAs) BranchNames() gitdomain.RemoteBranchNames {
	result := gitdomain.RemoteBranchNames(maps.Keys(self))
	result.Sort()
	return result
}

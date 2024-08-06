package debug

import (
	"os"

	"github.com/git-town/git-town/v15/internal/cli/dialog"
	"github.com/git-town/git-town/v15/internal/cli/dialog/components"
	"github.com/git-town/git-town/v15/internal/git/gitdomain"
	"github.com/spf13/cobra"
)

func selectCommitAuthorCmd() *cobra.Command {
	return &cobra.Command{
		Use: "select-commit-author",
		RunE: func(_ *cobra.Command, _ []string) error {
			branch := gitdomain.NewLocalBranchName("feature-branch")
			authors := []gitdomain.Author{"Jean-Luc Picard <captain@enterprise.com>", "William Riker <numberone@enterprise.com>"}
			dialogTestInputs := components.LoadTestInputs(os.Environ())
			_, _, err := dialog.SelectSquashCommitAuthor(branch, authors, dialogTestInputs.Next())
			return err
		},
	}
}

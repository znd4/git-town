package dialog

import (
	"slices"

	"github.com/git-town/git-town/v16/internal/cli/dialog/components"
	"github.com/git-town/git-town/v16/internal/cli/dialog/components/list"
	"github.com/git-town/git-town/v16/internal/config/configdomain"
	. "github.com/git-town/git-town/v16/pkg/prelude"
)

type CredentialMethodOption string

const (
	credentialMethodPlaintext CredentialMethodOption = "Plaintext"
	CredentialMethodScript    CredentialMethodOption = "Script"
)

func CredentialMethod(priorCredentialMethod Option[CredentialMethodOption], inputs components.TestInput) (CredentialMethodOption, bool, error) {
	entries := []CredentialMethodOption{credentialMethodPlaintext, CredentialMethodScript}
	cursor := slices.Index(entries, priorCredentialMethod.GetOrDefault())
	selection, aborted, err := components.RadioList(list.NewEntries(entries...), cursor, "Placeholder Title", "Placeholder Help", inputs)
	return selection, aborted, err
}

func (self CredentialMethodOption) String() string {
	return string(self)
}

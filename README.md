# ChatOKF tap

A Homebrew tap with one cask: the notarized ChatOKF disk image published
at [leok7v/ChatOKF](https://github.com/leok7v/ChatOKF/releases).

    brew tap leok7v/chatokf https://github.com/leok7v/ChatOKF.tap
    brew install --cask chatokf

The explicit URL is needed once because this repository is not named
`homebrew-chatokf`.

This tap is separate from the application repository for a practical
reason: `brew tap` clones the whole repository, and ChatOKF carries a
132 MB model as a Git LFS object. Homebrew runs git without git-lfs on
its PATH, so cloning ChatOKF as a tap fails outright, and where it
succeeds it would fetch the model to obtain one small Ruby file.

Nothing here needs updating when ChatOKF is released. The cask points
at GitHub's "latest release" redirect, so a new tag changes what it
downloads on its own, with no schedule and no token.

The cost is that Homebrew cannot tell one version from another, so
`brew upgrade` skips it. To move to a newer release:

    brew reinstall --cask chatokf

Apple Silicon and macOS 15 or newer. The app is signed with a Developer
ID certificate, notarized and stapled, so Gatekeeper accepts it even
though Homebrew quarantines cask installs.

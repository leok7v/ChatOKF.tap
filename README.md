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

`brew upgrade` moves you to a newer release, and `brew outdated` says
when there is one. The cask names a version and a digest, so Homebrew
can compare them.

Those two lines are written by `.github/workflows/cask.yml`, never by
hand. Release ChatOKF, then tag THIS repository with the same `v` tag:
that tag runs the workflow, which reads ChatOKF's latest release and the
digest published beside the disk image, and commits the result here. If
the two tags disagree the run fails rather than writing, so the cask
cannot name one release and describe another.

Apple Silicon and macOS 15 or newer. The app is signed with a Developer
ID certificate, notarized and stapled, so Gatekeeper accepts it even
though Homebrew quarantines cask installs.

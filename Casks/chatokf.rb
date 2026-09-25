# Homebrew cask for the DMG that .github/workflows/dmg.yml publishes.
#
# This repo is not named homebrew-*, so the tap is added with an explicit
# URL the first time:
#
#     brew tap leok7v/chatokf https://github.com/leok7v/ChatOKF.tap
#     brew install --cask chatokf
#
# There is no version or digest to keep current. The url is GitHub's
# "latest release" redirect, so a new tag changes what this downloads
# without anything here being edited, by a schedule or by a token.
#
# sha256 :no_check is the trade that buys it. The integrity guarantee
# does not come from a digest in a public file: the disk image and the
# app inside it are signed with a Developer ID certificate, notarized
# and stapled, and Homebrew quarantines cask installs, so Gatekeeper
# verifies that signature on first launch. A tampered download fails
# there, digest or no digest.

cask "chatokf" do
  version :latest
  sha256 :no_check

  url "https://github.com/leok7v/ChatOKF/releases/latest/download/ChatOKF.dmg"
  name "ChatOKF"
  desc "Chat app running GGUF models locally on Metal"
  homepage "https://github.com/leok7v/ChatOKF"

  # Float16 runs through the whole engine and does not exist on Intel;
  # project.yml excludes x86_64 for that reason, so there is no universal
  # build to offer.
  depends_on arch: :arm64
  # project.yml sets the macOS deployment target to 15.0.
  depends_on macos: :sequoia

  app "ChatOKF.app"

  # The app is sandboxed, so everything it owns lives in its container.
  # Models are tens of gigabytes and are downloaded on demand, which is
  # why zap and not uninstall: removing them is an explicit act.
  zap trash: [
    "~/Library/Containers/io.github.leok7v.ChatOKF",
    "~/Library/Group Containers/group.io.github.leok7v.ChatOKF",
    "~/Library/Application Scripts/io.github.leok7v.ChatOKF",
  ]
end

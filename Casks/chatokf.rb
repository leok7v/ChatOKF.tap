# Homebrew cask for the DMG that .github/workflows/dmg.yml publishes.
#
# This repo is not named homebrew-*, so the tap is added with an explicit
# URL the first time:
#
#     brew tap leok7v/chatokf https://github.com/leok7v/ChatOKF.tap
#     brew install --cask chatokf
#
# version and sha256 are written by .github/workflows/cask.yml, which
# reads them from ChatOKF's latest release. Do not edit them by hand.
#
# THIS REPO IS TAGGED WITH THE SAME v TAG AS ChatOKF. That tag is what
# runs the workflow, and the workflow refuses to write anything if the
# two disagree, so the cask cannot quietly describe a release that is
# not the one it names.

cask "chatokf" do
  version "26.09.25"
  sha256 "3209b0b674aea6d3c5c84fa58290aee42105653da9198717c102b154045d0235"

  url "https://github.com/leok7v/ChatOKF/releases/download/" \
      "v#{version}/ChatOKF.dmg"
  name "ChatOKF"
  desc "Chat app running GGUF models locally on Metal"
  homepage "https://github.com/leok7v/ChatOKF"

  # Float16 runs through the whole engine and does not exist on Intel;
  # project.yml excludes x86_64 for that reason, so there is no universal
  # build to offer.
  depends_on arch: :arm64
  # project.yml sets the macOS deployment target to 15.0.
  depends_on macos: :sequoia

  # brew can compare versions again, so `brew outdated` and `brew upgrade`
  # work without --greedy, and livecheck tells it where to look.
  livecheck do
    url :url
    strategy :github_latest
  end

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

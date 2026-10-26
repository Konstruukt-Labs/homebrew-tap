# Homebrew cask for FazerWM — stable releases only (betas reach users via the
# app's own Sparkle beta channel, never here).
#
# CI owns the version/sha256 lines: on every stable release the pipeline in
# Konstruukt-Labs/fazerwm-build (private) rewrites them via the GitHub
# contents API (Scripts/update_cask.sh in the private app repo). Everything
# below those two lines is hand-maintained and survives bumps untouched.
#
# Until the first stable release ships, the placeholders are not installable.
# Manual bump (fallback): set version + sha256 (`shasum -a 256
# FazerWM-<version>.dmg` of the released dmg), then verify:
#   brew install --cask ./Casks/fazerwm.rb
#   brew audit --cask --new ./Casks/fazerwm.rb
#   brew style --cask ./Casks/fazerwm.rb
cask "fazerwm" do
  version "2026.10.26"
  sha256 "6059d947bbb9c8d32c7b53e153ef917765c3c07cc391d96ed2d769ff639da308"

  # Artifacts live on the public releases repo (private source repo builds them):
  #   https://github.com/Konstruukt-Labs/fazerwm/releases
  url "https://github.com/Konstruukt-Labs/fazerwm/releases/download/v#{version}/FazerWM-#{version}.dmg"
  name "FazerWM"
  desc "Scrollable-tiling window manager with virtual workspaces"
  homepage "https://fazerwm.app"

  livecheck do
    url :github_latest
  end

  # Sparkle in-app updates are the primary update path; brew will not nag on `brew upgrade`.
  auto_updates true
  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  # Apple Silicon only — no arch stanza needed since there is a single artifact.
  app "FazerWM.app"

  zap trash: [
    "~/.config/FazerWM",                                       # user config (survives uninstall by design — delete manually if desired)
    "~/Library/Caches/com.konstruuktlabs.FazerWM",             # IPC socket, Sparkle caches
    "~/Library/Preferences/com.konstruuktlabs.FazerWM.plist",  # UserDefaults
  ]
end

# Homebrew cask for QLCodePreview — stable releases only.
#
# Bumping is manual: after each stable release, set version to the CalVer
# tag (vYYYY.MM.DD) and sha256 from the release's QLCodePreview-<version>.zip.sha256
# sidecar (or `shasum -a 256` the downloaded zip). Automating this in the
# qlcodepreview-build pipeline would need a second token scoped to this tap
# repo; until then, two lines per release. Everything below those two lines
# is hand-maintained and survives bumps untouched.
#
# Verify after bumping (audit needs the tap-qualified name, so register
# this repo as a tap first — brew tap konstruukt-labs/tap /path/to/homebrew-tap):
#   brew audit --cask konstruukt-labs/tap/qlcodepreview
#   brew style --cask Casks/qlcodepreview.rb
#   brew install --cask ./Casks/qlcodepreview.rb
cask "qlcodepreview" do
  version "2026.09.16"
  sha256 "c5c014cde6edbf9de49d06de613179a7895ebe44f3b5c7e4c6ad7ba4c42a0297"

  # Universal zip (signed + notarized + stapled), built by the private
  # qlcodepreview-build pipeline and published on the public source repo:
  #   https://github.com/Konstruukt-Labs/qlcodepreview/releases
  url "https://github.com/Konstruukt-Labs/qlcodepreview/releases/download/v#{version}/QLCodePreview-#{version}.zip"
  name "QLCodePreview"
  desc "Syntax-highlighted Quick Look previews for source code"
  homepage "https://konstruukt.com/projects/qlcodepreview"

  livecheck do
    url "https://github.com/Konstruukt-Labs/qlcodepreview/releases/latest"
    strategy :github_latest
  end

  depends_on macos: :monterey
  # Universal build (arm64 + x86_64) — single artifact, no arch stanza.

  # No in-app updater: `brew upgrade` is the update path for this cask.
  app "QLCodePreview.app"

  caveats <<~EOS
    Enable the extension once after installing:
    System Settings -> General -> Login Items & Extensions -> Quick Look -> QLCodePreview = ON
    (macOS refuses to let installers do this step.)
  EOS

  zap trash: [
    "~/Library/Group Containers/group.com.konstruuktlabs.QLCodePreview",  # App-Group defaults (settings shared with the extension)
    "~/Library/Preferences/com.konstruuktlabs.QLCodePreview.plist",       # host app defaults
  ]
end

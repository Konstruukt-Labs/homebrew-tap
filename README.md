# Konstruukt Labs Homebrew tap

Homebrew tap for [Konstruukt Labs](https://github.com/Konstruukt-Labs) apps.
One cask per app, each pointing at that app's GitHub Releases — this repo
contains no build logic, only the installers' metadata.

## Install

One-time: current Homebrew requires trusting third-party taps.

    brew trust konstruukt-labs/tap
    brew install --cask konstruukt-labs/tap/fazerwm
    brew install --cask konstruukt-labs/tap/qlcodepreview

| Cask | Description | Requirements | Homepage |
|---|---|---|---|
| [`fazerwm`](./Casks/fazerwm.rb) | Scrollable-tiling window manager with virtual workspaces | macOS 14 (Sonoma)+, Apple Silicon | [fazerwm.app](https://fazerwm.app) |
| [`qlcodepreview`](./Casks/qlcodepreview.rb) | Syntax-highlighted Quick Look previews for source code | macOS 12 (Monterey)+, universal (arm64 + Intel) | [konstruukt.com/projects/qlcodepreview](https://konstruukt.com/projects/qlcodepreview) |

## Notes

- Casks track **stable releases only**. Pre-release builds reach users
  through the apps' own in-app update channels, never through this tap.
- FazerWM self-updates (Sparkle), so `brew upgrade` is never needed after
  installing; QLCodePreview has no in-app updater, so `brew upgrade` is its
  update path. Either way, Homebrew is just the install vector.
- Issues for a specific app belong in that app's public repo (e.g.
  [Konstruukt-Labs/fazerwm/issues](https://github.com/Konstruukt-Labs/fazerwm/issues),
  [Konstruukt-Labs/qlcodepreview/issues](https://github.com/Konstruukt-Labs/qlcodepreview/issues)).

## Maintainers

CI owns the `version`/`sha256` lines in each cask: the release pipeline in
the private `fazerwm-build` repo bumps them via the GitHub contents API on
every stable release, and `qlcodepreview-build` does the same for
`qlcodepreview` once its pipeline is wired up. Don't hand-edit those two
lines — edit anything else (name, desc, deps, zap) directly; bumps rewrite
only version and sha256, leaving the rest of the file untouched.

Manual bump (fallback, or to seed the first release): set `version` +
`sha256` (`shasum -a 256 FazerWM-<version>.dmg` of the released dmg), then
verify locally before pushing:

    brew install --cask ./Casks/fazerwm.rb
    brew audit --cask --new ./Casks/fazerwm.rb
    brew style --cask ./Casks/fazerwm.rb

### Official homebrew-cask (later)

Once an app has traction, its cask can be proposed for
`Homebrew/homebrew-cask`, giving the plain `brew install --cask fazerwm`
with no tap. Their bar: stable versioned releases (GitHub Releases
qualifies), a working homepage, signed + notarized builds, and maintainers
who respond to update PRs. This tap keeps working regardless.

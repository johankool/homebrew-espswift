# Homebrew tap for ESPSwift

[ESPSwift](https://github.com/johankool/espswift): Embedded Swift for RISC-V based ESP32 chips, in Xcode or in Terminal, on macOS and Linux.

## Install

```bash
brew tap johankool/espswift
brew trust --tap johankool/espswift
brew trust --formula espressif/eim/eim
brew install --HEAD espswift
espswift setup
```

Homebrew asks you to trust taps other than its own: this one, and Espressif's (`espressif/eim`), whose EIM, the ESP-IDF Installation Manager, installs ESP-IDF.

`espswift setup` installs ESP-IDF, the Swift toolchain and, on macOS, the Xcode template. `espswift doctor` checks everything is in order.

On macOS (Apple Silicon), Homebrew installs a built espswift (a bottle); elsewhere, it builds espswift from the release's source, which needs Xcode on macOS. Update it with `brew upgrade espswift`. `brew install --HEAD espswift` builds the main branch instead.

## Formulae

| Formula | |
|---------|---|
| `espswift` | ESPSwift's command-line tool and its Xcode template |

## Publishing a release's bottles

1. Update `url` and `sha256` in `Formula/espswift.rb` for the new release (the autobump workflow opens a pull request for it each day there's one), in a pull request.
2. The **brew test-bot** workflow builds and tests the formula, and keeps its bottles as an artifact.
3. Once it passes, run the **brew pr-pull** workflow (Actions ▸ brew pr-pull ▸ Run workflow) with the pull request's number. It attaches the bottles to a release of this tap, adds their `bottle do` block to the formula, and pushes that to `main`, which closes the pull request.

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

Until ESPSwift has releases, the formula builds espswift from the main branch (`--HEAD`), which needs Xcode on macOS. Update it with `brew upgrade --fetch-HEAD espswift`.

## Formulae

| Formula | |
|---------|---|
| `espswift` | ESPSwift's command-line tool and its Xcode template |

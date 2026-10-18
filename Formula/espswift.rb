# espswift: Embedded Swift for RISC-V based ESP32 chips.
#
# Installs espswift and its Xcode template; espswift setup then installs
# ESP-IDF (with Espressif's EIM) and the Swift toolchain. On macOS
# (Apple Silicon) it's a bottle; brew install --HEAD espswift builds the
# main branch.
class Espswift < Formula
  desc "Embedded Swift for RISC-V ESP32 chips: create, build, flash, monitor and debug"
  homepage "https://github.com/johankool/espswift"
  url "https://github.com/johankool/espswift/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f3a5749616c02839b2b8bed9428bb50dc36b53577d02f52cafc55bed68defe77"
  license "MIT"
  head "https://github.com/johankool/espswift.git", branch: "main"

  # ESP-IDF needs CMake and the Python that espswift pins (ESP-IDF 6.1
  # doesn't support Homebrew's newer default Python). EIM, which installs
  # ESP-IDF, isn't a dependency: its formula has no bottles, so espswift's
  # couldn't have one. Install it next to espswift (see the caveats);
  # espswift setup says so if it's missing.
  depends_on "cmake"
  depends_on "python@3.14"

  on_macos do
    # Building espswift needs Swift 6, which comes with Xcode.
    depends_on xcode: ["26.0", :build]
  end

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--package-path", "cli"
    bin.install "cli/.build/release/espswift"
    # espswift finds its Xcode template in share/espswift.
    pkgshare.install "Xcode Template"
  end

  def caveats
    <<~EOS
      espswift setup installs ESP-IDF with Espressif's EIM. If you don't
      have EIM yet, install it first:
        brew tap espressif/eim
        brew trust --formula espressif/eim/eim
        brew install espressif/eim/eim
      Then, to install ESP-IDF, the Swift toolchain and the Xcode template, run:
        espswift setup
      Then check everything is in order with:
        espswift doctor
    EOS
  end

  test do
    # Creating a project needs the template from share/espswift. With the
    # board and the example given, espswift doesn't ask for them.
    system bin/"espswift", "new", "Blinky", "--board", "esp32-c6-devkitc-1", "--example", "blink",
           "--folder", testpath
    assert_path_exists testpath/"Blinky/Blinky/sdkconfig.defaults"
    assert_match "esp32c6", (testpath/"Blinky/Blinky/sdkconfig.defaults").read
  end
end

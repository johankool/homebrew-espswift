# espswift: Embedded Swift for RISC-V based ESP32 chips.
#
# Until there are releases, this builds espswift from the repository's main
# branch: brew install --HEAD espswift. espswift setup then installs ESP-IDF
# (with Espressif's EIM), the Swift toolchain and the Xcode template.
class Espswift < Formula
  desc "Embedded Swift for RISC-V ESP32 chips: create, build, flash, monitor and debug"
  homepage "https://github.com/johankool/espswift"
  license "MIT"
  head "https://github.com/johankool/espswift.git", branch: "main"

  # ESP-IDF needs CMake and the Python that espswift pins (ESP-IDF 6.1
  # doesn't support Homebrew's newer default Python); EIM installs ESP-IDF.
  depends_on "cmake"
  depends_on "espressif/eim/eim"
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
      To install ESP-IDF, the Swift toolchain and the Xcode template, run:
        espswift setup
      Then check everything is in order with:
        espswift doctor
    EOS
  end

  test do
    # Creating a project needs the template from share/espswift.
    system bin/"espswift", "new", "Blinky", "--folder", testpath
    assert_path_exists testpath/"Blinky/Blinky/sdkconfig.defaults"
  end
end

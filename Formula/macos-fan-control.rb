class MacosFanControl < Formula
  desc "Experimental Apple Silicon fan controller for macOS"
  homepage "https://github.com/marcocestari-tn/macos-fan-control"
  url "https://github.com/marcocestari-tn/macos-fan-control/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "da4f2333896ac8775f156a7f90dbe39e426307a3cb364a6bd951012c41b9a3b6"
  license "MIT"

  bottle do
    root_url "https://github.com/marcocestari-tn/homebrew-tap/releases/download/macos-fan-control-0.3.2"
    sha256 arm64_tahoe: "6ea126e720974de0ec07aaf61578cb706566440e8f934f4f44738373ae93880d"
  end

  depends_on arch: :arm64
  depends_on "macmon"
  depends_on macos: :ventura

  def install
    system "./build-cli.sh"
    bin.install ".build-cli/fan-control-cli" => "fan-control"
  end

  def caveats
    <<~EOS
      Fan control starts only after an explicit privileged command, for example:
        sudo fan-control ramp --min 35 --max 70 --sustain 5

      Before removing this formula, stop and clean up the root-owned daemon:
        sudo fan-control uninstall
        brew uninstall macos-fan-control
    EOS
  end

  test do
    assert_match "fan-control 0.3.2", shell_output("#{bin}/fan-control --version")
    assert_match "self-test: OK", shell_output("#{bin}/fan-control --self-test")
  end
end

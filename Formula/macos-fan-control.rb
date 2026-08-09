class MacosFanControl < Formula
  desc "Experimental Apple Silicon fan controller for macOS"
  homepage "https://github.com/marcocestari-tn/macos-fan-control"
  url "https://github.com/marcocestari-tn/macos-fan-control/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "6481756ef99250a08034878b63659188eb7877662bdfbb0c927affcfb8badcc1"
  license "MIT"

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
        sudo fan-control ramp --min 35 --max 70

      Before removing this formula, stop and clean up the root-owned daemon:
        sudo fan-control uninstall
        brew uninstall macos-fan-control
    EOS
  end

  test do
    assert_match "fan-control 0.1.1", shell_output("#{bin}/fan-control --version")
    assert_match "self-test: OK", shell_output("#{bin}/fan-control --self-test")
  end
end

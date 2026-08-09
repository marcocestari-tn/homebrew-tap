class MacosFanControl < Formula
  desc "Experimental Apple Silicon fan controller for macOS"
  homepage "https://github.com/marcocestari-tn/macos-fan-control"
  url "https://github.com/marcocestari-tn/macos-fan-control/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "1ac25674ea2b8a7bc924985c93e6fec7fd8aee0740c2544a1bd27aeee85f7f40"
  license "MIT"

  bottle do
    root_url "https://github.com/marcocestari-tn/homebrew-tap/releases/download/macos-fan-control-0.4.2"
    sha256 arm64_tahoe: "b5a8b5f210b37f717070a7a5f9f69594f81455d9ea9eceeb7517f68835d522ba"
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
    assert_match "fan-control #{version}", shell_output("#{bin}/fan-control --version")
    assert_match "self-test: OK", shell_output("#{bin}/fan-control --self-test")
  end
end

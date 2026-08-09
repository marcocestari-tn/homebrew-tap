class MacosFanControl < Formula
  desc "Experimental Apple Silicon fan controller for macOS"
  homepage "https://github.com/marcocestari-tn/macos-fan-control"
  url "https://github.com/marcocestari-tn/macos-fan-control/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f3cf0012b965df5632328ab32e62560dd4ee18a8136ba4ef71f7f2f9e1d8c2f0"
  license "MIT"

  bottle do
    root_url "https://github.com/marcocestari-tn/homebrew-tap/releases/download/macos-fan-control-0.2.0"
    sha256 arm64_tahoe: "1f8fc5617696a5d0a7ab98581252a767aada7c039df2d1872a06f57014b77fb6"
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
        sudo fan-control ramp --min 35 --max 70

      Before removing this formula, stop and clean up the root-owned daemon:
        sudo fan-control uninstall
        brew uninstall macos-fan-control
    EOS
  end

  test do
    assert_match "fan-control 0.2.0", shell_output("#{bin}/fan-control --version")
    assert_match "self-test: OK", shell_output("#{bin}/fan-control --self-test")
  end
end

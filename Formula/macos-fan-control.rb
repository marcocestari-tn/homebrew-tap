class MacosFanControl < Formula
  desc "Experimental Apple Silicon fan controller for macOS"
  homepage "https://github.com/marcocestari-tn/macos-fan-control"
  url "https://github.com/marcocestari-tn/macos-fan-control/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "334c57a77129b22454f9f404494a6d505fac6c9e6aeff034888a787523e0f54d"
  license "MIT"

  bottle do
    root_url "https://github.com/marcocestari-tn/homebrew-tap/releases/download/macos-fan-control-0.1.0"
    rebuild 1
    sha256 arm64_tahoe: "927ac7e43aca2b57a2de13190eb99aef6a5c90d1c5f0838218bcda86f4576484"
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
    assert_match "fan-control 0.1.0", shell_output("#{bin}/fan-control --version")
    assert_match "self-test: OK", shell_output("#{bin}/fan-control --self-test")
  end
end

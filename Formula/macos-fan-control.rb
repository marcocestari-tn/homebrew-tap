class MacosFanControl < Formula
  desc "Experimental Apple Silicon fan controller for macOS"
  homepage "https://github.com/marcocestari-tn/macos-fan-control"
  url "https://github.com/marcocestari-tn/macos-fan-control/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "2261b711296945180f45d95f197ae0ea213478e5b900624cb55bd7ed95929f65"
  license "MIT"

  bottle do
    root_url "https://github.com/marcocestari-tn/homebrew-tap/releases/download/macos-fan-control-0.4.3"
    sha256 arm64_tahoe: "2c6664abf88397afe42343cba36981fa1714a73fb1f1b1e72d62efdb81df07f1"
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

      After upgrading this formula, refresh the privileged daemon while keeping
      its current profile:
        sudo fan-control update

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

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.11.0.tar.gz"
  sha256 "f5ffc4984ee4f9e722a38f0bc5a09c305fdd158b785549e1c193214cdeeab288"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.11.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5630ab0ce6929b2f29a04030e0cffd85a41a3cc7b7c68ec5167973b54befd33c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a110fbaff1c0e1ac7c8d9b17e71014961a9241bf1cf0e88fa94610d949796ea6"
    sha256 cellar: :any_skip_relocation, sequoia:      "b5dcfeef76071812cac246f1fedcc17e5a4d5151675a6c6dff05f4396034f59b"
  end

  depends_on "chafa"
  depends_on macos: :sonoma

  def install
    cd "tools/music" do
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/music"
    end
  end

  def caveats
    <<~EOS
      musictui drives the Music app via AppleScript; macOS will ask for
      automation permission on first use.

      The binary is `music`. Run `music` for the TUI, `music --help` for
      the CLI. Catalog search, playlist CRUD, and discovery additionally
      need Apple Music API auth: `music auth setup`.
    EOS
  end

  test do
    assert_match "3.11.0", shell_output("#{bin}/music --version")
  end
end

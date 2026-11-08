class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.26.1.tar.gz"
  sha256 "b44af7b59a40bfcab0ac97f9a920334c31a11e369810cab575b8a73bf2380806"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.26.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8eb47e9234aa6052cc778e13f650815ff4a63a74d48b85dfc7e2c585b7740d98"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e5ac2196edd5783b4aca2f2713de29b3cfb5f2dffbd4ec31be37f2743ba9b97"
    sha256 cellar: :any_skip_relocation, sequoia:       "36bba25d3beb9bf7e85c17ef01a7dd760354c92c3a9a21b08651ff02e8c79f23"
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
      musictui drives Apple's Music app via AppleScript; macOS asks for
      automation permission on first use.

      The binary is `music`: `music` for the TUI, `music --help` for the CLI.
      Playback, speakers, your library and playlist basics need no setup.
      Catalog search needs a MusicKit key: `music auth setup`.
      Adding to your library, Discover, recommendations and history also
      need a user token: `music auth`. Check with `music auth status`.
    EOS
  end

  test do
    assert_match "3.26.1", shell_output("#{bin}/music --version")
  end
end

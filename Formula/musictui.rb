class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.1.tar.gz"
  sha256 "46125f277d0f23f0d611f4f2674d7c3dcd94ce8834403b2048327e98ca03a0b0"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "89dbc6741e613ebb6a8c05925bbd6755310934bbca9869fd5b0b5a3746556d64"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a3ae022f53e94fcab20bec46c35ac5efc27aacf5b81a47ae8ba2f467d5a3f196"
    sha256 cellar: :any_skip_relocation, sequoia:      "84e849bc126db60c7f1b1b710544a3853944cf45024a3103bcd88febf308d5c6"
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
    assert_match "3.20.1", shell_output("#{bin}/music --version")
  end
end

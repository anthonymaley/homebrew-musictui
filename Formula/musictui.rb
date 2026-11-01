class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.24.5.tar.gz"
  sha256 "2b4f561ef00996bb50febca51bcf1f5def417bf20ce5d611057f81cee72c9610"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.24.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "de929593669078c84b602064d0b109fbb3236300ab8d0d4c1d6d20b0a3fbf2e0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "01ee8ffdc9cbc4f603b75c3be6517046c9ac0d0b8afe745326927cbf66def65a"
    sha256 cellar: :any_skip_relocation, sequoia:       "d92f4b10d072dd9a4912919c0c6276cfaeab8e8fedf3983827e2afa1a96de345"
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
    assert_match "3.24.5", shell_output("#{bin}/music --version")
  end
end

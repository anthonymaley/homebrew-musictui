class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.24.1.tar.gz"
  sha256 "efad445688ae643c05315740c05fb6b941188f459454819b03bc4293e5b4a239"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.24.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d98a3184620307790465c430ad2267dd6579931eb04a1a73dcc335f3ab48e434"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fdb2b8d550449168cd82177c29b78735197902281d57d15f7c038114370789d5"
    sha256 cellar: :any_skip_relocation, sequoia:       "fb084445632daff0f526e4fe58da45e9ad31f6bb3db50b5e8720e67df5eb05a0"
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
    assert_match "3.24.1", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.25.0.tar.gz"
  sha256 "e85109e67d3cd7c8a7d6fafe0508cf3f47af7f6b491a677cd0e39274e8639c76"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.25.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4610ceba15a18cdbe55d7fda4fe850a163c70218ad3118d8822b9cf1abcddab8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d8c2149417147e04c8eae209d3bfb713688cf728e421fa1c94f7c35ed1391e6"
    sha256 cellar: :any_skip_relocation, sequoia:       "9fa648f812eb25e322a0b7c65a5e7caab68b858ad9d60277fb7350c7f10acf61"
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
    assert_match "3.25.0", shell_output("#{bin}/music --version")
  end
end

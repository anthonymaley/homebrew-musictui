class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.24.2.tar.gz"
  sha256 "ad7313d684054c38c18a7932b472afa167f5714639ba94616f326a65e2f08b59"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.24.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e3f822b55d2771d213fb2b6d6810397287794f9d7cb45f3b7c5e387dc4b76ecd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8ff4e568ded46105c6a196fe066cc8cc9dc4c3b18d304f596ca43d53519e87fc"
    sha256 cellar: :any_skip_relocation, sequoia:       "b32921d7ce7777b3d1c619695cd3adc47537762acb31e52d7bb35f6a835ac192"
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
    assert_match "3.24.2", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.24.0.tar.gz"
  sha256 "11c37766114da0bff74203cd8e9cdf94f60309d74ecf8b2cba672b0fa4f28e78"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.24.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "68576ea831215977288a6cd1b319925aa9e5f66effbf0d5adf638f4950790961"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d5f5763ec80ec7c110de77b3e4162d1088896114b5f2fddc61d4d5e0cfddf791"
    sha256 cellar: :any_skip_relocation, sequoia:       "d5d6b02b6306497bc77f3a82f9c463bad70afed664c1e7bb40926661df8406e0"
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
    assert_match "3.24.0", shell_output("#{bin}/music --version")
  end
end

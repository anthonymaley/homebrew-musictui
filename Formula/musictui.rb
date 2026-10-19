class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.22.1.tar.gz"
  sha256 "d177e2f0e51779cbac27fa0b52c6f23f4e6dd4802228d4e612e240ab88d960e2"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.22.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bcf789def87ef46ae09c9b5ebad1b751972f74cc9cb5e0711f2133dc78ccaf67"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d7cedb7b59f07aea94e92b14887d8e41f0f918fcbe7194240d2e9da4ec45fa32"
    sha256 cellar: :any_skip_relocation, sequoia:      "2834b3da8d661264766701561dc44f6bd7a77d3d3ab5c5cc63bca431ddc1be8e"
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
    assert_match "3.22.1", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.4.tar.gz"
  sha256 "02f10a5843755221e29fcabd25cbc56ea183c99d65d36e77c776bcbc9eb1214e"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "67df49adfa655ddb41e8b477582aeed2c795ea19a04a040937f34410ba7f4573"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "adcbec20f3d58409e60f11e498e84693a80c21a160e83d05ca44013488d1e6e9"
    sha256 cellar: :any_skip_relocation, sequoia:      "50d0c43d9a9baa0a6592128e564c5282eaa01aeef6c329c8cb8c9a028b8d37ad"
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
    assert_match "3.20.4", shell_output("#{bin}/music --version")
  end
end

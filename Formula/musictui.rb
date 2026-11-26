class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.29.0.tar.gz"
  sha256 "33e0a1d28c5693043e5e862e127fff3f9416c6083a6b3edbc9f123c9bb29d862"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.29.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b40d46e5bab07ed5392ce54f1fc9d1c588de21e3ea2f84b9c13ccbf003aa0b87"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ea57fcbe7e0cc78807344f17ac872546c9b53b83599101fd1179e5768df77698"
    sha256 cellar: :any_skip_relocation, sequoia:       "046a4856bc4c8be55bb3687cabf14bf7b2c8829b1d537b2a581e3d2358bbd137"
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
    assert_match "3.29.0", shell_output("#{bin}/music --version")
  end
end

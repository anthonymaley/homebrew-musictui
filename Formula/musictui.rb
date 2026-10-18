class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.21.0.tar.gz"
  sha256 "7dcdcba5aa366da15efec268cd72a711bc62732753619b71ec003f7c8a05f7b1"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.21.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "153e5a7984ee87e83ce48150667caafcf2062ddc2ce1b1cfa72ec950ffd555d9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "58b1f9c1c9675fcc9ce7485db5f281bc5d82ebc89bf4c52c41ef692a1db95323"
    sha256 cellar: :any_skip_relocation, sequoia:      "e1086affeadc634bf5a40cc3f2bb18434123697145fc00877d91cc687c2ca07d"
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
    assert_match "3.21.0", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.5.tar.gz"
  sha256 "f997f32665a1c539aa9aabe821b919c6138b4ff7f07f1e4a577abd3bd4aa2e4f"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0b455c31ad611b05d1b87d39613258edbb0399f4d3ddce68a9697b33ea226355"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7875f1c21bd43915f57e064f4eb8f00722d6812dfef441de9201bd7540b04ce7"
    sha256 cellar: :any_skip_relocation, sequoia:      "8c6fb7166dd71650d63839303810bbdf4c84de7b5deb8d2ba9e0dbfc2b2c0659"
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
    assert_match "3.20.5", shell_output("#{bin}/music --version")
  end
end

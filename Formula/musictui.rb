class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.7.tar.gz"
  sha256 "b99e10014a54af26c38fc0fbf2c88cada671a46de0406a2b7e4bee3afd45396d"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8440fd2b5c4d9a30de11b3c7db822f395a7b3cab569a7ee4c13476f471f2bedc"
    sha256 cellar: :any_skip_relocation, sequoia:     "d1dae8d964aa72aaf9b121e9fef0a1b3f44560a54b1aa26098652bed711772ee"
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
    assert_match "3.20.7", shell_output("#{bin}/music --version")
  end
end

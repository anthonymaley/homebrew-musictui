class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.3.tar.gz"
  sha256 "0f15d0e2152267d8b76a343f3b881a56c28883644e21d05ca528aed81a271292"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a79cef1817d9ec92e365a93f179c7f6283479883eb87763cf67ba4a12bd38cf7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "475da3fb242525b327cecce7a9f77795cc3e6b4355e196d44147ade60a24db55"
    sha256 cellar: :any_skip_relocation, sequoia:      "3e9bc635c8631ce2975c5d9076fd8621c7fb20a0a8c415aaf0a1a36d26c42ba7"
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
    assert_match "3.20.3", shell_output("#{bin}/music --version")
  end
end

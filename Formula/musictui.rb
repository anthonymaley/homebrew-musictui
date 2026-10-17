class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.8.tar.gz"
  sha256 "49d0d48460baa5c0be53a567af90444dae1a634a6f7a6e6f7502f4efa69df3cd"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "526031e52d0248071a085b7b81825129cd3d7a0935cabfbba8e03d269e573098"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "92f8b1d530769643fda82c6baab8d900049f503cc65a77700ca86f430f20e873"
    sha256 cellar: :any_skip_relocation, sequoia:      "ce46010ade7a37c6a3b69d454ca4f93710756ec04c80755126ed1ecf7214ef2b"
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
    assert_match "3.20.8", shell_output("#{bin}/music --version")
  end
end

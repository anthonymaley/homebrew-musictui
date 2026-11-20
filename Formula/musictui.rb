class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.28.0.tar.gz"
  sha256 "237961c450633535716b2a91865f6538e6fcff9cbfa250e9d94fd9831b2f7462"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.28.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e19f701ab0cc1369258983d2ce6621912bbd351501920610cf8d5296b883ab2c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cbddf7c11e55d32bd0bf263bc1126a2f45a4fa0bc7336c5f655943b94207dbe7"
    sha256 cellar: :any_skip_relocation, sequoia:       "443621af17d334d1223c7780c2af19e6855846b2e94eecb1119cf38e303925f0"
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
    assert_match "3.28.0", shell_output("#{bin}/music --version")
  end
end

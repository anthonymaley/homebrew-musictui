class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.22.0.tar.gz"
  sha256 "db20920e3c5fcc261f6553f48e3ec71267f46306378f897c7d3c99ded449bb45"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.22.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4485df80a9faaaa02e01f7a5cb09c4dbe6232105e3ebe2b47a457fe75b3500e1"
    sha256 cellar: :any_skip_relocation, sequoia:     "6c11562d8e94d5a63c05d149fa3cf945a83f384ef0f08e1fae225d676eff4e49"
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
    assert_match "3.22.0", shell_output("#{bin}/music --version")
  end
end

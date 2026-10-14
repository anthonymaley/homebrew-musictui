class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.6.tar.gz"
  sha256 "2278d307bb0d19a5fc6b21c2d981348f7b2fdfe94eb7805599400e5ceaae5e50"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "64697408a26c3a036491b2bf3b03e693b4d31b7bab990ebdc690393403b7dbe1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "45a8b46232f56ef824366bed7272e8091c5b43f74724e833ac09e7f4b4b0fe3a"
    sha256 cellar: :any_skip_relocation, sequoia:      "6c96c06b1034653dd2a1f8ff3c309f3781229f0fde9216014816deed07a519eb"
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
    assert_match "3.20.6", shell_output("#{bin}/music --version")
  end
end

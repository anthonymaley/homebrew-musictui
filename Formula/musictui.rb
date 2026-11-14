class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.27.0.tar.gz"
  sha256 "42c5eeeadec2ebb0f32a7843b4bcdd990863c692fff2144f8dc2b78195a19160"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.27.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "53cf81dd4737da89cb370239119a21647b5a5e68f2aeab746157f9a777ebb49f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "64665748b7e10cc3f20b4c7b80cb483a647b3421321e21d52fa320be7fee4b4a"
    sha256 cellar: :any_skip_relocation, sequoia:       "8ddd4554693e73aa628421e76374cbe83e599ad11e712a2d2824a876d8e2b380"
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
    assert_match "3.27.0", shell_output("#{bin}/music --version")
  end
end

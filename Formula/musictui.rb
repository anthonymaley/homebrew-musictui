class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.24.4.tar.gz"
  sha256 "2f2e2999fb215a53b6ef48f7e50159ce02618b62cd501b961562fbea28b212af"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.24.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2b1167734b3c398423a7d6139547af6dd20a7fc1f1f029debde8f44cc467bc38"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e8d3375eef5c14f8cb937506049ba331d483f1b06856429febd93e0ca34e1a0d"
    sha256 cellar: :any_skip_relocation, sequoia:       "29f125eb8a8ac8a472cd0a976fe4112b5a8c5077abc5fbab0bf6774762efc505"
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
    assert_match "3.24.4", shell_output("#{bin}/music --version")
  end
end

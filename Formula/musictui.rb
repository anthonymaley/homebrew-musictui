class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.25.2.tar.gz"
  sha256 "4d4682bfd09dbef2bc3bfa410666c4ce0d4318ef10bae2c99f378afdb7adac75"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.25.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4de3a2033e760a504e0ae76153a56c783b37c5d708546a40290604e72bacc61f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3b415ac8ca03b30c7051586d9e92dc86ad01ca61c653bdc6ab7d7018bb031800"
    sha256 cellar: :any_skip_relocation, sequoia:       "1e1d70dbca351709182dc345f0079bce68d9f9ea6759278cf0037fe1efd60bb4"
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
    assert_match "3.25.2", shell_output("#{bin}/music --version")
  end
end

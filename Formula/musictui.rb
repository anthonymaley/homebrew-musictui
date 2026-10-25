class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.23.0.tar.gz"
  sha256 "0e596201ff979f7919a69d0c631585416b65d0c2f6e93d76420a9a07f63472a9"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.23.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "64aeb790e25dc0dd57632265d235b1d1cca546c83bdb13f7b33ce10313541b23"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "daf02be3f0cd6b17d4d1ec50091dcaf6ee4c9d592db4609032fa9aafe1df2ecd"
    sha256 cellar: :any_skip_relocation, sequoia:      "f2d13b31eca493c5ab9de3b62413fa4eda1f19fa64cd2bc6664f0fd2fe0febe2"
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
    assert_match "3.23.0", shell_output("#{bin}/music --version")
  end
end

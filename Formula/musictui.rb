class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.19.0.tar.gz"
  sha256 "09be3547e630c260ec645f6c9748836a18954bef817a642b109700de3bf19ccb"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.19.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "472e92997d688164ac2c6fbf4d7b3d3d5a264191ceb7bd7363976bd4882b45ef"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d5e3803df324471965aab1bf6ac691f2ba0bfa6dc07ffd1237fd8ddd565b7005"
    sha256 cellar: :any_skip_relocation, sequoia:      "4c5123464f67e5cbd6b86c938ce31444dad33330bb2139b30145c4a6880132d1"
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
    assert_match "3.19.0", shell_output("#{bin}/music --version")
  end
end

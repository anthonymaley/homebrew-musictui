class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.20.0.tar.gz"
  sha256 "b0a2a2270cee7687bed95e374277376c42456cf160e5de123b8fc7141386f353"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.20.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a19c8690eebd8954c894e458f8ac47b10aca9de5421c9f8d4fbdd846e57df8eb"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c1b5f4145fbc57a58b2b7364e7da63de3a28bea12ca6e6b1d8b889136f963723"
    sha256 cellar: :any_skip_relocation, sequoia:      "c66cc821699493ea0b4483e075c078e3187e0013893bf9ef37ed36736e4995a3"
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
    assert_match "3.20.0", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.10.2.tar.gz"
  sha256 "139cbc254ccf26261aa293a9c3d306f19bac57078139b74ce436f8da63c346d1"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.10.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d65a8195718c54f2883945779c40bed0ac5c83ab23b92e4478f8b76761dccc5b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7f494c119550d1f97d87f791ed2c5a610cab0e8dc248e691494a20e53f2dc692"
    sha256 cellar: :any_skip_relocation, sequoia:      "40d7d8a1af3193ca38d7ccf85db73cfc968474199de303978d54d6be962fab33"
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
      musictui drives the Music app via AppleScript; macOS will ask for
      automation permission on first use.

      The binary is `music`. Run `music` for the TUI, `music --help` for
      the CLI. Catalog search, playlist CRUD, and discovery additionally
      need Apple Music API auth: `music auth setup`.
    EOS
  end

  test do
    assert_match "3.10.2", shell_output("#{bin}/music --version")
  end
end

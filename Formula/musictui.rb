class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.12.0.tar.gz"
  sha256 "507fbb68061555be151ca474fa3103f571e6daba6ab1df27b2269d3736a42a9e"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.12.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4241784b2ecd7acc0a3e2f8398c32737bbb927ae879a5f0f9f3a085c53906564"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ea8073975881e084ad3203ba7ed9886896be7ec12704418d39aea48fa08a66bc"
    sha256 cellar: :any_skip_relocation, sequoia:      "967d0bc460e61e371abeed6f6258d010f498471795793cca3e421fda734d8a6e"
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
    assert_match "3.12.0", shell_output("#{bin}/music --version")
  end
end

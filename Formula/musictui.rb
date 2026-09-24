class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.14.0.tar.gz"
  sha256 "e464a67d850316bb02dabcc1a879a7c8e3ac018b5763bb7ea8cf0867eb71b1b9"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.14.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "353ad0e7304bf498f9cc5a22ab533d83138eb5e83e34d1c5a133f7a4fd9ba488"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "68a76f298d7b7c316650cec1c11f6bf9758336b5ad42bfaaf8cce45ae2a284ba"
    sha256 cellar: :any_skip_relocation, sequoia:      "8130922bd02f2e49dd022edce41dc33fdb79b26990c42fb288cf2ddc2fafab17"
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
    assert_match "3.14.0", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.7.2.tar.gz"
  sha256 "ad50a016158df70bc8d6baca36c8c8c5c02d7ea0cf0a8c97a691a4c52bd12089"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["15.0", :build]
  depends_on "chafa"

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
    assert_match "3.7.2", shell_output("#{bin}/music --version")
  end
end

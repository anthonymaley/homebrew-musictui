class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, library browsing, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/musictui/archive/refs/tags/v3.5.0.tar.gz"
  sha256 "99928153af46e8bc1ebff2189a97db185fbf50cd01c472a8c68e5def37427823"
  license "MIT"
  head "https://github.com/anthonymaley/musictui.git", branch: "main"

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
    assert_match "3.5.0", shell_output("#{bin}/music --version")
  end
end

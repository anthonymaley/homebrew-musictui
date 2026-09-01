class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.10.3.tar.gz"
  sha256 "93912ece3ad3b2bebe933802fa79adbb3be20cd8c3acfa1cf42073e91c312536"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.10.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3d07330cb7e70b690ab9cedc40fb7adb277d22f374991283ff1c2fde39f4a903"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d65f61aa0578a08f10e2dd6d87eb975eeaedfefe091aa02222145422e10a754c"
    sha256 cellar: :any_skip_relocation, sequoia:      "229e68d067672b52013baceca8974af4c6ce1c10b349eb4d6385943e6e21b877"
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
    assert_match "3.10.3", shell_output("#{bin}/music --version")
  end
end

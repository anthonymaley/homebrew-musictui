class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.16.0.tar.gz"
  sha256 "88c0a244396f77d76598a90be8faeed9ca000277e6afdf9dd18b525699190bdf"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.16.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "cf41c357f9c98bc7febf53bc84171390adb3b4115ef77f15f13761913d7b9436"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "309b09a283000a7a472832e925bf77ec64e33758b5211c3f18f686b25ddd09d2"
    sha256 cellar: :any_skip_relocation, sequoia:      "ff010add8c320c32643b55d722a9fb0c40496af64e85289849c38872ae1b85b7"
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
    assert_match "3.16.0", shell_output("#{bin}/music --version")
  end
end

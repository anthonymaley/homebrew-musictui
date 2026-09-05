class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.13.0.tar.gz"
  sha256 "0e9c95b13cc398d0a113b5c0a8a5aa757e1ffcfdec527ce8d60c446ab2c71301"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.13.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "eb02cb035eb8f7d90a4de7be8736f0a5fd6ce2c268ce73ae5f455d469e2572f6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "eb2ba99fc97124e169caaa0d4177ee7738b619b06eed11f271a7b6dd857ca000"
    sha256 cellar: :any_skip_relocation, sequoia:      "8f034fb53bd139d16c43d3a930cc056fb558278270be9eb28ccb2503cee711b4"
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
    assert_match "3.13.0", shell_output("#{bin}/music --version")
  end
end

class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.17.0.tar.gz"
  sha256 "87f02c3ab00853c6a6e064137f338c18fda3292e2407bd515435ac4c4883c439"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.17.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2990fad05e4dd1c530f4cbf6ab60dd982628f28b8a6ffb5fc5ebeb93882a916d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5c956aab54e32c2d65b844624845de30c33837d3c699ff5fa8880086acbd2aab"
    sha256 cellar: :any_skip_relocation, sequoia:      "ca0244ee40dfedb3abe9487ef3b207e281cb3fabf34aa9fa831cd875be5921b3"
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
    assert_match "3.17.0", shell_output("#{bin}/music --version")
  end
end

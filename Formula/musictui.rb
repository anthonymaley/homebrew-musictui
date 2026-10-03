class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.18.1.tar.gz"
  sha256 "9a2f55eeb4592a7918ea1773cddd7603914a5c9fbe1b8c63842d4e6bf2526504"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.18.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "af7a817a53dd70fb73972e04cb040203a8115081780ff38284b93b6f86a94e21"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "49694c3909b3b78e3eac9ba29a08f8f24c43a2ac0880da6c3d24e71905ba8e38"
    sha256 cellar: :any_skip_relocation, sequoia:      "fe3317f0e62a546f754019082553c74aa9ae2b2af78d81fe86a0a19ba01f728f"
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
    assert_match "3.18.1", shell_output("#{bin}/music --version")
  end
end

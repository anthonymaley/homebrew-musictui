class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.25.1.tar.gz"
  sha256 "bde39274c234c29f5b0be227b4baf62b3f895da6d1ea9f0e47be74fa1c318a7f"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.25.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5e469ae9a4677d78c9f434e29c93638f840421b5d9a45f002785e8b2df4028b4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "09d49e49d169ad5c2e4bde329d79f19c2e0cf091cf1543a3e892d8d02a6a8571"
    sha256 cellar: :any_skip_relocation, sequoia:       "a64de8ab122fdac5aac9477dd8cc0dadb8bc0dd0dd265a3da1fbd3c2a29f496e"
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
    assert_match "3.25.1", shell_output("#{bin}/music --version")
  end
end

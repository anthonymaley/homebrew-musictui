class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.24.3.tar.gz"
  sha256 "f662f95bed8b6babe1af537cf5c6bf0778cf49e82d8ab4f8a79d0a333a4bc16f"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.24.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "003693d63b59e847b29640f8988414d94898562a9ee19c27878fb5e93dce7c57"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4d60324d36dd71867bac77040b6eb156ab399443130857db52088f9443bf542f"
    sha256 cellar: :any_skip_relocation, sequoia:       "98a1e16c2c83856f749c913387b28b90c99b0098f19d5f21e9f0f4ad14295121"
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
    assert_match "3.24.3", shell_output("#{bin}/music --version")
  end
end

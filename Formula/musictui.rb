class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.18.0.tar.gz"
  sha256 "9857441dcdc4b8d14a47563a654b4ef56b4044c9a8e5bf2bf9b9739c3ba7da37"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.18.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e15ef2aaf7aeb936b4a7759cc530297b746fc0dcfa920066bc340d75784dc714"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e4cc14e3c88f40a096b7e67c06dae3246fc6f74a756ac55be53855ea04ae0ab3"
    sha256 cellar: :any_skip_relocation, sequoia:      "ccb11455829627ad073cb0f8c1223524a99362547d3cdf563e25a75e7687afca"
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
    assert_match "3.18.0", shell_output("#{bin}/music --version")
  end
end

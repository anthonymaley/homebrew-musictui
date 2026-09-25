class Musictui < Formula
  desc "Apple Music TUI + CLI: multi-room AirPlay, radio, library, venue EQ"
  homepage "https://musictui.com"
  url "https://github.com/anthonymaley/MusicTUI/archive/refs/tags/v3.15.0.tar.gz"
  sha256 "b408ad87f4f09c91558d6658ab8a6b37365f4b8e5ddb0b5f97419771c022a0c5"
  license "MIT"
  head "https://github.com/anthonymaley/MusicTUI.git", branch: "main"

  bottle do
    root_url "https://github.com/anthonymaley/MusicTUI/releases/download/v3.15.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e218e6f2d792f750c1bfa627d01e0e9e62052e4e79211164430b8d3f03a08e37"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cb1f1c7df12994ca0f0dc0a6dcb324fe24619c6a32daaa5caee745e77cec8a91"
    sha256 cellar: :any_skip_relocation, sequoia:      "3ec50acee399fc29ccda7aefcbd8e80e0eb28699a0e831604772e376aa4c85e4"
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
    assert_match "3.15.0", shell_output("#{bin}/music --version")
  end
end

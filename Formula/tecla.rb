class Tecla < Formula
  desc "A quiet, fast typing test for the terminal"
  homepage "https://github.com/ardaydilek/tecla"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ardaydilek/tecla/releases/download/v0.1.0/tecla-aarch64-apple-darwin.tar.xz"
      sha256 "deaa6ceb83b991bf1a47b4ef7c2ba282d7f2e6a340d4d8246e702b69093eb6a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ardaydilek/tecla/releases/download/v0.1.0/tecla-x86_64-apple-darwin.tar.xz"
      sha256 "04b2cb6cb3e4527b657473bc119adad378e921eb78ef3d5a39e46ca409584fc7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ardaydilek/tecla/releases/download/v0.1.0/tecla-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ee2f02eed251957fde00da693184911b0384364dece98480e9aea54d402479de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ardaydilek/tecla/releases/download/v0.1.0/tecla-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3d07b2cf32a4cb9990710f19bbb691d94e4eea64918dd926ae36762688d9bb7"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tecla"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tecla"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tecla"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tecla"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

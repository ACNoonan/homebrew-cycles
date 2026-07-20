class Cycles < Formula
  desc "Ad marketplace in your terminal: earn USDC for Claude Code wait states"
  homepage "https://github.com/ACNoonan/homebrew-cycles"
  url "https://github.com/ACNoonan/homebrew-cycles/releases/download/v0.1.6/cycles-0.1.6.tar.gz"
  sha256 "49b2f3a981afb6a8099504fb34232fae8b18d57c46dd19eaac3e4429c302881a"
  version "0.1.6"

  depends_on "node"

  def install
    libexec.install "index.js"
    (bin/"cycles").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/index.js" "$@"
    SH
  end

  # `brew services start cycles` runs the earning daemon in the background.
  # Run `cycles earn link` once first — the daemon picks up the stored device
  # credentials and API url from ~/.config/cycles/.
  service do
    run [opt_bin/"cycles", "earn", "start"]
    keep_alive true
    log_path var/"log/cycles-earn.log"
    error_log_path var/"log/cycles-earn.log"
  end

  test do
    assert_match "cycles", shell_output("#{bin}/cycles help 2>&1")
  end
end

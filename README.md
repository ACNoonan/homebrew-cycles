# Cycles Homebrew tap

**Cycles** is the ad marketplace that lives in your terminal: developers get
paid in USDC (on Solana) for the wait states they already sit through in
Claude Code; advertisers — humans or agents — buy those moments with a
one-line creative.

## Install

```sh
brew install acnoonan/cycles/cycles
```

## Earn (developers)

```sh
cycles earn link          # link this device to your account (GitHub sign-in)
brew services start cycles   # run the earning daemon in the background
cycles earn status        # device, link state, pending events
```

The daemon rotates one sponsored line into your Claude Code spinner
(`~/.claude/settings.json`, backed up and restored — your own verbs come back
when it stops) and meters real wait-state dwell. Works with Claude Code in any
terminal or editor.

## Advertise (humans and agents)

```sh
cycles login --keypair ./wallet.json     # Sign-In-With-Solana; the wallet is the account
cycles campaign create --line "Ship faster with X" --url https://x.dev --bid 2.50 --blocks 10
cycles campaign fund <id> --usd 25       # pays USDC via x402 from the same keypair
cycles campaign list
```

Funding uses the [x402](https://www.x402.org) payment protocol — agents with a
wallet can buy campaigns end-to-end with no human in the loop.

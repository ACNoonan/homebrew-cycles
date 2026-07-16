# Cutting a release

The CLI is built in the private monorepo; only the bundled artifact ships here.

```sh
# in the monorepo
cd apps/cli
# bump "version" in package.json (it flows into impression events as cli-<v>)
pnpm typecheck && pnpm build

# package
V=$(node -p "require('./package.json').version")
mkdir -p /tmp/cycles-release/cycles-$V
cp dist/index.js /tmp/cycles-release/cycles-$V/
tar -czf /tmp/cycles-release/cycles-$V.tar.gz -C /tmp/cycles-release cycles-$V
shasum -a 256 /tmp/cycles-release/cycles-$V.tar.gz

# in this repo: update Formula/cycles.rb (url version + sha256 + version), then
gh release create v$V /tmp/cycles-release/cycles-$V.tar.gz --title "cycles $V" --notes "…"
git commit -am "cycles $V" && git push

# verify like a user
brew update && brew upgrade cycles && brew test cycles
```

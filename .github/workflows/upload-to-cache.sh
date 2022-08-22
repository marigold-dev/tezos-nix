#!/usr/bin/env bash
set -euo pipefail

CACHE_ENDPOINT=$1

pathsToPush=$(comm -13 <(sort ~/.nix-store-paths) <(./.github/workflows/list-nix-store.sh))

export PATH=$PATH:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/per-user/runner/profile/bin

echo "Signing and uploading paths: [$pathsToPush]"

exec nix copy --verbose --to "$CACHE_ENDPOINT&compression=zstd&parallel-compression=true&secret-key=/etc/nix/nix-cache-key.sec" $pathsToPush
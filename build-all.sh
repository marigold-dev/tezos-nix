#! /usr/bin/env bash

set -e

flags="$1"
wanted_version=${2-"not_set"}

build_stuff () {
  prefix=$1
  protocol=$2
  echo "Building client"
  nix build ".#${prefix}octez-client" "$flags"

  echo "Building codec"
  nix build ".#${prefix}octez-codec" "$flags"

  echo "Building octez-dal-node"
  nix build ".#${prefix}octez-dal-node" "$flags"

  echo "Building node"
  nix build ".#${prefix}octez-node" "$flags"

  echo "Building proxy-server"
  nix build ".#${prefix}octez-proxy-server" "$flags"

  echo "Building signer"
  nix build ".#${prefix}octez-signer" "$flags"

  echo "Building octez-snoop"
  nix build ".#${prefix}octez-snoop" "$flags"

  echo "Building tezos-tps-evaluation"
  nix build ".#tezos-tps-evaluation" "$flags"

  echo "Building octez-smart-rollup-wasm-debugger"
  nix build ".#${prefix}octez-smart-rollup-wasm-debugger" "$flags"

  echo "Building accuser-alpha"
  nix build ".#${prefix}octez-accuser-alpha" "$flags"

  echo "Building baker-alpha"
  nix build ".#${prefix}octez-baker-alpha" "$flags"

  echo "Building smart-rollup-client-alpha"
  nix build ".#${prefix}octez-smart-rollup-client-alpha" "$flags"

  echo "Building smart-rollup-node-alpha"
  nix build ".#${prefix}octez-smart-rollup-node-alpha" "$flags"

  echo "Building accuser-$protocol"
  nix build ".#${prefix}octez-accuser-$protocol" "$flags"

  echo "Building baker-$protocol"
  nix build ".#${prefix}octez-baker-$protocol" "$flags"

  echo "Building smart-rollup-client-$protocol"
  nix build ".#${prefix}octez-smart-rollup-client-$protocol" "$flags"

  echo "Building smart-rollup-node-$protocol"
  nix build ".#${prefix}octez-smart-rollup-node-$protocol" "$flags"

  if [ "$prefix" = "trunk-" ]; then
    echo "Building octez-dac-node"
    nix build ".#${prefix}octez-dac-node" "$flags"

    echo "Building octez-evm-proxy"
    nix build ".#${prefix}octez-evm-proxy" "$flags"
  fi
} 

if [ "$wanted_version" = "not_set" ]; then

  versions=("RELEASE" "NEXT" "TRUNK")

  for v in "${versions[@]}"; do
    echo "BUILDING $v"
    if [ "$v" = "RELEASE" ]; then
      prefix=""
      protocol="PtMumbai"
    elif [ "$v" = "NEXT" ]; then
      prefix="next-"
      protocol="PtNairob"
    else
      prefix="trunk-"
      protocol="PtNairob"
    fi

    build_stuff "$prefix" "$protocol"
  done
else
  build_stuff "$wanted_version-" "$3"
fi
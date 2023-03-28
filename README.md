# nix-tezos

nix flakes for tezos. Provides derivations for all executables, overlay for all libraries and a development environment to work on Tezos itself.

## Development environment

When working on [Tezos](https://gitlab.com/tezos/tezos) you can get a complete development shell by running the following command:

```sh
nix develop github:marigold-dev/tezos-nix#dev
```

If you accept the substituters you should also get a cache that is populated from CI running in this repo.

## Packages

Packages are provided in 2 flavours, `release` and `trunk`. The release packages are updated as soon after a release as possible and sometimes we even target the RC. Trunk is updated daily via our CI.

Packages from release have the name you would expect and trunk adds the `trunk-` prefix.

### Available packages

#### Release

- octez-client
- octez-codec
- octez-dal-node
- octez-node
- octez-proxy-server
- octez-signer
- octez-snoop
- tezos-tps-evaluation
- octez-smart-rollup-wasm-debugger
- octez-accuser-alpha
- octez-baker-alpha
- octez-smart-rollup-client-alpha
- octez-smart-rollup-node-alpha
- octez-accuser-PtMumbai
- octez-baker-PtMumbai
- octez-smart-rollup-client-PtMumbai
- octez-smart-rollup-node-PtMumbai

#### Trunk

- trunk-octez-client
- trunk-octez-codec
- trunk-octez-dac-node
- trunk-octez-dal-node
- trunk-octez-evm-proxy
- trunk-octez-node
- trunk-octez-proxy-server
- trunk-octez-signer
- trunk-octez-snoop
- trunk-octez-testnet-scenarios
- trunk-tezos-tps-evaluation
- trunk-octez-smart-rollup-wasm-debugger
- trunk-octez-accuser-alpha
- trunk-octez-baker-alpha
- trunk-octez-smart-rollup-client-alpha
- trunk-octez-smart-rollup-node-alpha
- trunk-octez-accuser-PtMumbai
- trunk-octez-baker-PtMumbai
- trunk-octez-smart-rollup-client-PtMumbai
- trunk-octez-smart-rollup-node-PtMumbai

## overlays

There are 2 overlays provided, one for `release` and one for `trunk`. `default` is an alias of `release`.

```
├───overlays
│   ├───default: Nixpkgs overlay
│   ├───release: Nixpkgs overlay
│   └───trunk: Nixpkgs overlay
```

{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-error-monad,
  tezos-benchmark,
  tezos-crypto,
  tezos-context,
  tezos-shell-context,
  tezos-micheline,
}:
buildDunePackage {
  pname = "tezos-shell-benchmarks";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-stdlib
    tezos-base
    tezos-error-monad
    tezos-benchmark
    tezos-crypto
    tezos-context
    tezos-shell-context
    tezos-micheline
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: shell benchmarks";
    };
}

{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-crypto,
  tezos-benchmark,
  bisect_ppx,
}:
buildDunePackage {
  pname = "tezos-benchmark-examples";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-crypto
    tezos-benchmark
  ];

  checkInputs = [bisect_ppx];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

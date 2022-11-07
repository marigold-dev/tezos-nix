{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-lazy-containers,
  tezos-lwt-result-stdlib,
  data-encoding,
}:
buildDunePackage {
  pname = "tezos-tree-encoding";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-lazy-containers
    tezos-lwt-result-stdlib
    data-encoding
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "A general-purpose library to encode arbitrary data in Merkle trees";
    };
}

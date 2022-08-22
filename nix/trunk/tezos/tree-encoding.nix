{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  lazy-containers,
  tezos-lwt-result-stdlib,
  data-encoding,
}:
buildDunePackage {
  pname = "tree-encoding";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-base
    lazy-containers
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

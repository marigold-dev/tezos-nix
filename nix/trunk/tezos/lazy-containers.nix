{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-tree-encoding,
  zarith,
}:
buildDunePackage {
  pname = "tezos-lazy-containers";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-tree-encoding
    zarith
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "A collection of lazy containers whose contents is fetched from arbitrary backend on-demand";
    };
}

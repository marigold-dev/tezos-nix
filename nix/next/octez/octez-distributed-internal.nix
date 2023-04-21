{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
}:
buildDunePackage {
  pname = "octez-distributed-internal";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Fork of distributed. Use for Octez only";
    };
}

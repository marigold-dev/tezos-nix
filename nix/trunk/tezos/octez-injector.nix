{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  logs,
  tezos-stdlib-unix,
  tezos-crypto,
  tezos-micheline,
  tezos-client-base,
  tezos-workers,
  tezos-shell,
  octez-crawler,
}:
buildDunePackage {
  pname = "octez-injector";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    logs
    tezos-stdlib-unix
    tezos-crypto
    tezos-micheline
    tezos-client-base
    tezos-workers
    tezos-shell
    octez-crawler
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Octez: library for building injectors";
    };
}

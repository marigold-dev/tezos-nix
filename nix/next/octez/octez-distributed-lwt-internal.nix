{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  octez-distributed-internal,
  lwt,
  logs,
}:
buildDunePackage {
  pname = "octez-distributed-lwt-internal";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    octez-distributed-internal
    lwt
    logs
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Fork of distributed-lwt. Use for Octez only";
    };
}

{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, octez-distributed-internal
, lwt
, logs
,
}:
buildDunePackage {
  pname = "octez-distributed-lwt-internal";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-distributed-internal
    lwt
    logs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Fork of distributed-lwt. Use for Octez only";
    };
}

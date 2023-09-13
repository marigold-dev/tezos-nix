{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, logs
, tezos-client-base
, tezos-shell
, octez-crawler
,
}:
buildDunePackage {
  pname = "octez-injector";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    logs
    tezos-client-base
    tezos-shell
    octez-crawler
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library for building injectors";
    };
}

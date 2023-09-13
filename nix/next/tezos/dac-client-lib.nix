{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezos-client-base
, tezos-client-base-unix
, tezos-dac-lib
,
}:
buildDunePackage {
  pname = "tezos-dac-client-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-client-base
    tezos-client-base-unix
    tezos-dac-lib
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dac-client` library";
    };
}

{ lib
, buildDunePackage
, octez-libs
, tezos-signer-backends
, data-encoding
, alcotest-lwt
,
}:
buildDunePackage {
  pname = "tezos-client-commands";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-signer-backends data-encoding ];

  checkInputs = [ alcotest-lwt ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

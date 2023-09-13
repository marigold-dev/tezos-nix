{ lib
, buildDunePackage
, octez-libs
, tezos-mockup-registration
, tezos-mockup
, tezos-client-commands
,
}:
buildDunePackage {
  pname = "tezos-mockup-commands";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-mockup-registration tezos-mockup tezos-client-commands ];

  checkInputs = [ ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

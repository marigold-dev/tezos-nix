{ lib
, buildDunePackage
, octez-libs
, tezos-client-base
,
}:
buildDunePackage {
  pname = "tezos-mockup-registration";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-client-base ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

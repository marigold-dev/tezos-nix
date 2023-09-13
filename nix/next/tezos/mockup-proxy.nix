{ lib
, buildDunePackage
, octez-libs
, tezos-client-base
, resto-cohttp-self-serving-client
,
}:
buildDunePackage {
  pname = "tezos-mockup-proxy";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-client-base
    resto-cohttp-self-serving-client
  ];

  doCheck = true;

  meta = octez-libs.meta // { description = "Tezos: local RPCs"; };
}

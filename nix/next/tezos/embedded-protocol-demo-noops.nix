{ lib
, buildDunePackage
, octez-libs
, tezos-protocol-demo-noops
, tezos-protocol-updater
,
}:
buildDunePackage {
  pname = "tezos-embedded-protocol-demo-noops";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-protocol-demo-noops tezos-protocol-updater ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos/Protocol: demo_noops (economic-protocol definition, embedded in `tezos-node`)";
    };
}

{ lib
, buildDunePackage
, octez-libs
, tezos-validation
, tezos-store
,
}:
buildDunePackage {
  pname = "octez-node-config";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-validation
    tezos-store
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: `octez-node-config` library";
    };
}

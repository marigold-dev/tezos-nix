{ lib
, buildDunePackage
, octez-libs
,
}:
buildDunePackage {
  pname = "tezos-dal-node-services";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

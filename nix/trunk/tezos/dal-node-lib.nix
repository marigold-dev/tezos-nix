{ lib
, buildDunePackage
, cacert
, octez-libs
, tezos-dal-node-services
, octez-shell-libs
}:
buildDunePackage {
  pname = "tezos-dal-node-lib";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezos-dal-node-services
    octez-shell-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

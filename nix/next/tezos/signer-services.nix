{ lib
, buildDunePackage
, octez-libs
, tezos-client-base
,
}:
buildDunePackage {
  pname = "tezos-signer-services";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-client-base ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: descriptions of RPCs exported by `tezos-signer`";
    };
}

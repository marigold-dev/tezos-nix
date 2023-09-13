{ lib
, buildDunePackage
, octez-libs
, tezos-signer-services
, tezos-client-base
, uri
, tezt
, octez-alcotezt
,
}:
buildDunePackage rec {
  pname = "tezos-signer-backends";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-client-base
    tezos-signer-services
    uri
  ];

  checkInputs = [ tezt octez-alcotezt ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: remote-signature backends for `octez-client`";
    };
}

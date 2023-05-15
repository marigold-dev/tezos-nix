{
  lib,
  fetchurl,
  buildDunePackage,
  ledgerwallet,
  uecc,
  hex,
  secp256k1,
  alcotest,
}:
buildDunePackage rec {
  inherit (ledgerwallet) version src;
  pname = "ledgerwallet-tezos";

  duneVersion = "3";

  propagatedBuildInputs = [
    ledgerwallet
  ];

  checkInputs = [
    uecc
    hex
    secp256k1
    alcotest
  ];
}

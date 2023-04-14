{
  lib,
  fetchurl,
  buildDunePackage,
  rresult,
  cstruct,
  hidapi,
}:
buildDunePackage rec {
  pname = "ledgerwallet";
  version = "0.3.0";
  src = fetchurl {
    url = "https://github.com/vbmithr/ocaml-ledger-wallet/archive/${version}.tar.gz";
    sha256 = "sha256-NsvVn3dzzcaiaa09OZ2K2Vi1bDUCUJ9gCS1dJQP2RkE=";
  };

  duneVersion = "3";

  propagatedBuildInputs = [
    rresult
    cstruct
    hidapi
  ];
}

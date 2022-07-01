{ lib, buildDunePackage, tezos-stdlib, tezos-client-base }:

buildDunePackage {
  pname = "tezos-signer-services";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-client-base ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: descriptions of RPCs exported by `tezos-signer`";
  };
}

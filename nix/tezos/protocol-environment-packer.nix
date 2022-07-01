{ lib, buildDunePackage, tezos-stdlib }:

buildDunePackage {
  pname = "tezos-protocol-environment-packer";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  minimalOCamlVersion = "4.03";

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: sigs/structs packer for economic protocol environment";
  };
}

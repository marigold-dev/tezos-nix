{ lib, buildDunePackage, ocaml, tezos-stdlib, tezos-protocol-environment-packer
, zarith }:

buildDunePackage {
  pname = "tezos-protocol-environment-sigs";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/lib_protocol_environment";

  minimalOCamlVersion = "4.12";

  # propagatedBuildInputs = [ tezos-protocol-environment-packer ];

  checkInputs = [ tezos-stdlib ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: restricted typing environment for the economic protocols";
  };
}

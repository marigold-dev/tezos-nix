{ lib
, buildDunePackage
, ocaml
, tezos-stdlib
, tezos-protocol-environment-packer
, zarith
}:

buildDunePackage {
  pname = "tezos-protocol-environment-sigs";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs = [ tezos-protocol-environment-packer ];

  checkInputs = [ tezos-stdlib ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: restricted typing environment for the economic protocols";
  };
}

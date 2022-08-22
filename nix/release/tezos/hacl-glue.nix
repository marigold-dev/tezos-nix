{ lib, buildDunePackage, tezos-stdlib }:

buildDunePackage {
  pname = "tezos-hacl-glue";

  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: thin layer of glue around hacl-star (virtual package)";
  };
}

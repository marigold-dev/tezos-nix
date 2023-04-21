{
  lib,
  buildDunePackage,
  tezos-stdlib,
}:
buildDunePackage {
  pname = "tezos-hacl-glue";

  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: thin layer of glue around hacl-star (virtual package)";
    };
}

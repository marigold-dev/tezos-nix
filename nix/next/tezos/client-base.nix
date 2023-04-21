{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-shell-services,
  tezos-sapling,
  alcotest,
}:
buildDunePackage {
  pname = "tezos-client-base";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-shell-services tezos-sapling];

  checkInputs = [alcotest];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

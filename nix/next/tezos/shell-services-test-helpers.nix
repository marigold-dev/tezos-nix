{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-test-helpers,
  tezos-base,
  tezos-shell-services,
  qcheck-core,
  qcheck-alcotest,
}:
buildDunePackage {
  pname = "tezos-shell-services-test-helpers";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-base tezos-shell-services tezos-test-helpers qcheck-core];

  checkInputs = [qcheck-alcotest];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: shell_services test helpers";
    };
}

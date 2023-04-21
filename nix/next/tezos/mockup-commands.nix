{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-mockup-registration,
  tezos-mockup,
  tezos-client-commands,
}:
buildDunePackage {
  pname = "tezos-mockup-commands";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-mockup-registration tezos-mockup tezos-client-commands];

  checkInputs = [];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

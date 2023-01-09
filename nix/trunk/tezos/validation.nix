{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-context,
  tezos-stdlib-unix,
  tezos-protocol-environment,
  tezos-protocol-updater,
  tezos-shell,
  tezos-shell-context,
  tezos-validation,
  lwt-exit,
}:
buildDunePackage {
  pname = "tezos-validation";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-context
    tezos-stdlib-unix
    tezos-protocol-environment
    tezos-protocol-updater
    tezos-shell
    tezos-shell-context
    tezos-validation
    lwt-exit
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library for blocks validation";
    };
}

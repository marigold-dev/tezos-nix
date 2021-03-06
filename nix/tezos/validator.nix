{ lib
, buildDunePackage
, tezos-stdlib
, tezos-base
, tezos-context
, tezos-stdlib-unix
, tezos-protocol-environment
, tezos-protocol-updater
, tezos-shell
, tezos-shell-context
, tezos-validation
, lwt-exit
}:

buildDunePackage {
  pname = "tezos-validator";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

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

  meta = tezos-stdlib.meta // {
    description = "Tezos: library for blocks validation";
  };
}

{
  lib,
  ocaml,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-micheline,
  tezos-shell-services,
  tezos-protocol-environment,
  tezos-shell-context,
  octez-protocol-compiler,
  tezos-context,
  lwt-exit,
}:
buildDunePackage {
  pname = "tezos-protocol-updater";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  nativeBuildInputs = [
    octez-protocol-compiler
  ];

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-micheline
    tezos-shell-services
    tezos-protocol-environment
    tezos-shell-context
    tezos-context
    lwt-exit
    octez-protocol-compiler
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: economic-protocol dynamic loading for `tezos-node`";
    };
}

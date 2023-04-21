{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-error-monad,
  tezos-protocol-environment,
  tezos-context,
  tezos-shell-context,
}:
buildDunePackage {
  pname = "tezos-context-ops";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-error-monad
    tezos-protocol-environment
    tezos-context
    tezos-shell-context
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: backend-agnostic operations on contexts";
    };
}

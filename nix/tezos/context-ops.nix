{ lib
, buildDunePackage
, tezos-stdlib
, tezos-base
, tezos-error-monad
, tezos-protocol-environment
, tezos-context
, tezos-shell-context
}:

buildDunePackage {
  pname = "tezos-context-ops";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs =
    [
      tezos-base
      tezos-error-monad
      tezos-protocol-environment
      tezos-context
      tezos-shell-context
    ];


  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: backend-agnostic operations on contexts";
  };
}

{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-protocol-updater,
  octez-protocol-compiler,
  tezos-context-ops,
}:
buildDunePackage {
  pname = "tezos-validation";
  inherit (tezos-stdlib) version src;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-protocol-updater tezos-context-ops];

  nativeBuildInputs = [octez-protocol-compiler];

  strictDeps = true;

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library for blocks validation";
    };
}

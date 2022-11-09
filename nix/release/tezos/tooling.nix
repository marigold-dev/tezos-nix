{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  octez-protocol-compiler,
  bisect_ppx,
  ometrics,
  parsexp,
}:
buildDunePackage {
  pname = "tezos-tooling";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [bisect_ppx ometrics octez-protocol-compiler tezos-base];

  checkInputs = [parsexp];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: library of auto-documented command-line-parsing combinators";
    };
}

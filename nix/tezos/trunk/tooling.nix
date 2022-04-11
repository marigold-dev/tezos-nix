{ lib, buildDunePackage, tezos-stdlib, tezos-base, tezos-protocol-compiler
, bisect_ppx, ometrics, parsexp }:

buildDunePackage {
  pname = "tezos-tooling";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/tooling";

  propagatedBuildInputs =
    [ bisect_ppx ometrics tezos-protocol-compiler tezos-base ];

  checkInputs = [ parsexp ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: library of auto-documented command-line-parsing combinators";
  };
}

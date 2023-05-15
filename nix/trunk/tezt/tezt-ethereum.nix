{
  lib,
  buildDunePackage,
  tezos-stdlib,
  zarith,
  tezt,
  tezt-performance-regression,
}:
buildDunePackage {
  pname = "tezt-ethereum";
  inherit (tezos-stdlib) version src;
  duneVersion = "3";

  postPatch = ''
    ${tezos-stdlib.postPatch}
    substituteInPlace tezt/lib_ethereum/dune \
      --replace "(libraries" "(libraries zarith"
  '';

  propagatedBuildInputs = [
    zarith
    tezt
    tezt-performance-regression
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Ethereum test framework based on Tezt";
    };
}

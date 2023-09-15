{ lib
, buildDunePackage
, octez-libs
, zarith
, tezt
, tezt-performance-regression
,
}:
buildDunePackage {
  pname = "tezt-ethereum";
  inherit (octez-libs) version src;

  postPatch = ''
    ${octez-libs.postPatch}
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
    octez-libs.meta
    // {
      description = "Ethereum test framework based on Tezt";
    };
}

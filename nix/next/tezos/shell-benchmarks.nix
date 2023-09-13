{ lib
, buildDunePackage
, octez-libs
, tezos-benchmark
,
}:
buildDunePackage {
  pname = "tezos-shell-benchmarks";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    tezos-benchmark
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: shell benchmarks";
    };
}

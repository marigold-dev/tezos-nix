{ lib
, buildDunePackage
, octez-libs
, tezos-benchmark
, bisect_ppx
,
}:
buildDunePackage {
  pname = "tezos-benchmark-examples";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-benchmark
  ];

  checkInputs = [ bisect_ppx ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

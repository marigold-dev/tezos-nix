{ lib
, buildDunePackage
, python311
, octez-libs
, ppx_expect
, data-encoding
, prbnmcn-linalg
, prbnmcn-stats
, pringo
, pyml
, ocamlgraph
, ocaml-migrate-parsetree-2
, hashcons
, ocamlformat_0_24_1
}:
buildDunePackage {
  pname = "tezos-benchmark";
  inherit (octez-libs) version src;

  nativeBuildInputs = [ ocamlformat_0_24_1 ];

  propagatedBuildInputs = [
    octez-libs
    ppx_expect
    data-encoding
    prbnmcn-linalg
    prbnmcn-stats
    pringo
    pyml
    ocamlgraph
    ocaml-migrate-parsetree-2
    hashcons
  ];

  nativeCheckInputs = [ python311 ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

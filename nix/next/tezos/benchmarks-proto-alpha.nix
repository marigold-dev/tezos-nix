{ lib
, buildDunePackage
, python311
, octez-libs
, data-encoding
, prbnmcn-cgrph
, prbnmcn-dagger
, prbnmcn-dagger-stats
, prbnmcn-stats
, pringo
, pyml
, ocaml-migrate-parsetree
, ocamlgraph
,
}:
buildDunePackage {
  pname = "tezos-benchmarks-proto-alpha";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    data-encoding
    prbnmcn-cgrph
    prbnmcn-dagger
    prbnmcn-dagger-stats
    prbnmcn-stats
    pringo
    pyml
    ocamlgraph
  ];

  nativeCheckInputs = [ python311 ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

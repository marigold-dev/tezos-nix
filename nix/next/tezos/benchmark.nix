{
  lib,
  buildDunePackage,
  python311,
  octez-libs,
  ppx_expect,
  data-encoding,
  prbnmcn-linalg,
  prbnmcn-stats,
  pringo,
  pyml,
  ocamlgraph,
  # , ocaml-migrate-parsetree
  hashcons,
  ocamlformat,
}:
buildDunePackage {
  pname = "tezos-benchmark";
  inherit (octez-libs) version src;

  nativeBuildInputs = [ocamlformat];

  propagatedBuildInputs = [
    octez-libs
    ppx_expect
    data-encoding
    prbnmcn-linalg
    prbnmcn-stats
    pringo
    pyml
    ocamlgraph
    # ocaml-migrate-parsetree
    hashcons
  ];

  nativeCheckInputs = [python311];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

{
  lib,
  buildDunePackage,
  python311,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-crypto,
  tezos-micheline,
  tezos-clic,
  data-encoding,
  prbnmcn-cgrph,
  prbnmcn-dagger,
  prbnmcn-dagger-stats,
  prbnmcn-stats,
  pringo,
  pyml,
  ocaml-migrate-parsetree,
  ocamlgraph,
}:
buildDunePackage {
  pname = "tezos-benchmarks-proto-alpha";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-crypto
    tezos-micheline
    tezos-clic
    data-encoding
    prbnmcn-cgrph
    prbnmcn-dagger
    prbnmcn-dagger-stats
    prbnmcn-stats
    pringo
    pyml
    ocamlgraph
  ];

  nativeCheckInputs = [python311];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: `tezos-dal-node` RPC services";
    };
}

{
  lib,
  buildDunePackage,
  ocaml,
  tezos-stdlib,
  tezos-crypto,
  tezos-rust-libs,
  tezos-base-test-helpers,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-sapling";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-crypto tezos-rust-libs];

  checkInputs = [alcotest-lwt tezos-base-test-helpers];

  # requires the "zcash-params" files
  doCheck = false;

  preBuild = ''
    echo ${tezos-rust-libs}/lib/tezos-rust-libs
    ls ${tezos-rust-libs}
    ls ${tezos-rust-libs}/lib
    ls ${tezos-rust-libs}/lib/tezos-rust-libs
  '';

  # This is a hack to work around the hack used in the dune files
  OPAM_SWITCH_PREFIX = "${tezos-rust-libs}";

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos/Protocol: economic-protocol definition";
    };
}

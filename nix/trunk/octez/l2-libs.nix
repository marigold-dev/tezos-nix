{ lib
, buildDunePackage
, ppx_deriving
, ppx_import
, octez-libs
, zarith
, lwt
, ctypes
, tezos-rust-libs
, data-encoding
, index
, irmin-pack
, irmin
, aches-lwt
, tezt
, qcheck-alcotest
, octez-alcotezt
}:
buildDunePackage rec {
  pname = "octez-l2-libs";

  inherit (octez-libs) src version;

  propagatedBuildInputs = [
    ppx_deriving
    ppx_import
    octez-libs
    zarith
    lwt
    ctypes
    tezos-rust-libs
    data-encoding
    index
    irmin-pack
    irmin
    aches-lwt
  ];

  checkInputs = [
    tezt
    octez-alcotezt
    qcheck-alcotest
  ];

  doCheck = true;

  # This is a hack to work around the hack used in the dune files
  OPAM_SWITCH_PREFIX = "${tezos-rust-libs}";

  meta =
    octez-libs.meta
    // {
      description = "Octez layer2 libraries";
    };
}

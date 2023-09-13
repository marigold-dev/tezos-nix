{
  lib,
  buildDunePackage,
  octez-libs,
  #, octez-l2-libs
  data-encoding,
  bls12-381,
  zarith,
  zarith_stubs_js,
  class_group_vdf,
  aches,
  aches-lwt,
  tezt,
  octez-alcotezt,
  qcheck-alcotest,
  lwt,
}:
buildDunePackage rec {
  pname = "octez-proto-libs";

  inherit (octez-libs) src version;

  propagatedBuildInputs = [
    octez-libs
    # octez-l2-libs
    data-encoding
    bls12-381
    zarith
    zarith_stubs_js
    class_group_vdf
    aches
    aches-lwt
    tezt
  ];

  checkInputs = [
    octez-alcotezt
    qcheck-alcotest
    lwt
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez shell libraries";
    };
}

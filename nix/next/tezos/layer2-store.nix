{ lib
, buildDunePackage
, octez-libs
, irmin-pack
, irmin
, aches-lwt
, qcheck-alcotest
, octez-alcotezt
,
}:
buildDunePackage {
  pname = "tezos-layer2-store";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    irmin-pack
    irmin
    aches-lwt
  ];

  checkInputs = [
    qcheck-alcotest
    octez-alcotezt
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: layer2 storage utils";
    };
}

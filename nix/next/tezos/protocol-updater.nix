{ lib
, ocaml
, buildDunePackage
, octez-libs
, octez-protocol-compiler
, lwt-exit
,
}:
buildDunePackage {
  pname = "tezos-protocol-updater";
  inherit (octez-libs) version src;

  nativeBuildInputs = [
    octez-protocol-compiler
  ];

  propagatedBuildInputs = [
    lwt-exit
    octez-protocol-compiler
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: economic-protocol dynamic loading for `tezos-node`";
    };
}

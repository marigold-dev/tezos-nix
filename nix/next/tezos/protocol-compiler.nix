{ lib
, buildDunePackage
, octez-libs
, # , octez-proto-libs
  lwt
, ocp-ocamlres
, pprint
, tezos-version
,
}:
buildDunePackage {
  pname = "octez-protocol-compiler";
  inherit (octez-libs) version src;

  minimalOCamlVersion = "4.12";

  nativeBuildInputs = [
    ocp-ocamlres
  ];

  propagatedBuildInputs = [
    octez-libs
    # octez-proto-libs
    lwt
    tezos-version
    ocp-ocamlres

    # needed by ocp-ocamlres
    pprint
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: economic-protocol compiler";
    };
}

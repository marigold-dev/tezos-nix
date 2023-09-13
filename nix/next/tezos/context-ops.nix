{ lib
, buildDunePackage
, octez-libs
,
}:
buildDunePackage {
  pname = "tezos-context-ops";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: backend-agnostic operations on contexts";
    };
}

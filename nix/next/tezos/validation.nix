{ lib
, buildDunePackage
, octez-libs
, tezos-protocol-updater
, octez-protocol-compiler
, tezos-context-ops
,
}:
buildDunePackage {
  pname = "tezos-validation";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ tezos-protocol-updater tezos-context-ops ];

  nativeBuildInputs = [ octez-protocol-compiler ];

  strictDeps = true;

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: library for blocks validation";
    };
}

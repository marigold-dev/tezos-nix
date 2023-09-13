{ lib
, buildDunePackage
, octez-libs
, octez-protocol-compiler
,
}:
buildDunePackage {
  pname = "tezos-protocol-demo-noops";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ octez-protocol-compiler ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos/Protocol: demo_noops economic-protocol definition";
    };
}

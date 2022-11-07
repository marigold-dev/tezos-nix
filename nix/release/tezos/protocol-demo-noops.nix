{
  lib,
  buildDunePackage,
  tezos-stdlib,
  octez-protocol-compiler,
}:
buildDunePackage {
  pname = "tezos-protocol-demo-noops";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [octez-protocol-compiler];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos/Protocol: demo_noops economic-protocol definition";
    };
}

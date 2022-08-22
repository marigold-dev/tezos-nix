{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-crypto,
  tezos-protocol-environment-packer,
  bls12-381-legacy,
}:
buildDunePackage {
  pname = "tezos-protocol-environment-structs";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [tezos-crypto tezos-protocol-environment-packer bls12-381-legacy];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: restricted typing environment for the economic protocols";
    };
}

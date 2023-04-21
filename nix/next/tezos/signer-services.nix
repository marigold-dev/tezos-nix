{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-client-base,
}:
buildDunePackage {
  pname = "tezos-signer-services";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-client-base];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: descriptions of RPCs exported by `tezos-signer`";
    };
}

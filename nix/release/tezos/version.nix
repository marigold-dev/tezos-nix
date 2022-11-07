{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  ppx_deriving,
  dune-configurator,
  alcotest,
}:
buildDunePackage {
  pname = "tezos-version";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-base ppx_deriving dune-configurator];

  checkInputs = [alcotest];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: version information generated from Git";
    };
}

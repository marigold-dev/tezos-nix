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
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [tezos-base ppx_deriving dune-configurator];

  checkInputs = [alcotest];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: version information generated from Git";
    };
}

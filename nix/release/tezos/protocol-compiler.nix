{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-version,
  tezos-protocol-environment,
  ocp-ocamlres,
  pprint,
}:
buildDunePackage {
  pname = "tezos-protocol-compiler";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-version
    tezos-protocol-environment
    ocp-ocamlres
    pprint
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: economic-protocol compiler";
    };
}

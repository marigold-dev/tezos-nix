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
  pname = "octez-protocol-compiler";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  minimalOCamlVersion = "4.12";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-version
    tezos-protocol-environment
    ocp-ocamlres
    pprint
  ];

  preBuild = ''
    echo ${tezos-protocol-environment}/
  '';

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: economic-protocol compiler";
    };
}

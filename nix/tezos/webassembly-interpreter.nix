{ lib
, fetchpatch
, buildDunePackage
, tezos-stdlib
, tezos-lwt-result-stdlib
, zarith
, qcheck-core
, qcheck-alcotest
, alcotest
}:

buildDunePackage {
  pname = "tezos-webassembly-interpreter";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-lwt-result-stdlib
    zarith
  ];

  checkInputs = [
    qcheck-core
    qcheck-alcotest
    alcotest
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: WebAssembly reference interpreter with tweaks for Tezos";
  };
}

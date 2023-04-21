{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezt,
}:
buildDunePackage {
  pname = "octez-alcotezt";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezt
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Provide the interface of Alcotest for Octez, but with Tezt as backend";
    };
}

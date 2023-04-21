{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-p2p-services,
  tezos-version,
  tezos-context,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-shell-services";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-p2p-services
    tezos-version
    tezos-context
  ];

  doCheck = true;

  checkInputs = [alcotest-lwt];

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: descriptions of RPCs exported by `tezos-shell`";
    };
}

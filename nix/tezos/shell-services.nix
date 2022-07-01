{ lib
, buildDunePackage
, tezos-stdlib
, tezos-workers
, tezos-p2p-services
, tezos-version
, alcotest-lwt
}:

buildDunePackage {
  pname = "tezos-shell-services";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-workers tezos-p2p-services tezos-version ];

  doCheck = true;

  checkInputs = [ alcotest-lwt ];

  meta = tezos-stdlib.meta // {
    description = "Tezos: descriptions of RPCs exported by `tezos-shell`";
  };
}

{ lib
, buildDunePackage
, tezos-stdlib
, tezos-rpc-http-client-unix
, tezos-signer-services
, alcotest
, alcotest-lwt
}:

buildDunePackage rec {
  pname = "tezos-signer-backends";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}/src";

  postPatch = ''
    echo "(lang dune 3.2)" > dune-project
  '';

  propagatedBuildInputs = [ tezos-rpc-http-client-unix tezos-signer-services ];

  checkInputs = [ alcotest alcotest-lwt ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: remote-signature backends for `tezos-client`";
  };
}

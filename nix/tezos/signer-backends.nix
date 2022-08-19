{ lib
, buildDunePackage
, tezos-stdlib
, tezos-signer-services
, tezos-base
, tezos-client-base
, tezos-rpc-http
, tezos-rpc-http-client
, tezos-rpc-http-client-unix
, tezos-shell-services
, uri
, alcotest
, alcotest-lwt
}:

buildDunePackage rec {
  pname = "tezos-signer-backends";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  postPatch = ''
    cp ./opam/* ./
    rm -rf vendors
    echo "(lang dune 3.2)" > dune-project
  '';

  propagatedBuildInputs = [
    tezos-base
    tezos-client-base
    tezos-rpc-http
    tezos-rpc-http-client
    tezos-rpc-http-client-unix
    tezos-shell-services
    tezos-signer-services
    uri
  ];

  checkInputs = [ alcotest alcotest-lwt ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: remote-signature backends for `tezos-client`";
  };
}

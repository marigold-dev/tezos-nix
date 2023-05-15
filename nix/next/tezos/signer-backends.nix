{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-signer-services,
  tezos-base,
  tezos-client-base,
  tezos-rpc-http,
  tezos-rpc-http-client,
  tezos-rpc-http-client-unix,
  tezos-shell-services,
  uri,
  tezt,
  octez-alcotezt,
}:
buildDunePackage rec {
  pname = "tezos-signer-backends";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

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

  checkInputs = [tezt octez-alcotezt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: remote-signature backends for `octez-client`";
    };
}

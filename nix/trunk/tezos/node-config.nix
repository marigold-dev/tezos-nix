{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-stdlib-unix,
  tezos-shell-services,
  tezos-rpc-http,
  tezos-rpc-http-server,
  tezos-context,
  tezos-validation,
}:
buildDunePackage {
  pname = "octez-node-config";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-stdlib-unix
    tezos-shell-services
    tezos-rpc-http
    tezos-rpc-http-server
    tezos-context
    tezos-validation
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Octez: `octez-node-config` library";
    };
}

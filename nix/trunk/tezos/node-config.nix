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
  tezos-store,
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
    tezos-store
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Octez: `octez-node-config` library";
    };
}

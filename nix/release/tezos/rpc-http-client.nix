{ lib, buildDunePackage, tezos-stdlib, tezos-rpc-http, resto-cohttp-client }:

buildDunePackage {
  pname = "tezos-rpc-http-client";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-rpc-http resto-cohttp-client ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: library of auto-documented RPCs (http client)";
  };
}

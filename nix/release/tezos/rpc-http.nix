{ lib
, buildDunePackage
, tezos-stdlib
, tezos-base
, resto-directory
, resto-cohttp
}:

buildDunePackage {
  pname = "tezos-rpc-http";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-base resto-directory resto-cohttp ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: library of auto-documented RPCs (http server and client)";
  };
}

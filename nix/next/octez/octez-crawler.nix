{
  lib,
  fetchpatch,
  buildDunePackage,
  tezos-stdlib,
  tezos-base,
  tezos-rpc-http,
  tezos-stdlib-unix,
  tezos-client-base,
  tezos-shell,
}:
buildDunePackage {
  pname = "octez-crawler";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    tezos-base
    tezos-rpc-http
    tezos-stdlib-unix
    tezos-client-base
    tezos-shell
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Octez: library to crawl blocks of the L1 chain";
    };
}

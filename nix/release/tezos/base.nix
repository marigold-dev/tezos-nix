{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-crypto,
  tezos-hacl,
  data-encoding,
  tezos-micheline,
  tezos-error-monad,
  tezos-test-helpers,
  tezos-rpc,
  tezos-clic,
  tezos-event-logging,
  tezos-stdlib-unix,
  ezjsonm,
  ptime,
  ipaddr,
  lwt,
}:
buildDunePackage {
  pname = "tezos-base";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-stdlib
    tezos-crypto
    data-encoding
    tezos-error-monad
    tezos-rpc
    tezos-clic
    tezos-micheline
    tezos-event-logging
    ptime
    ezjsonm
    ipaddr
    lwt
    ipaddr
    tezos-hacl
    tezos-stdlib-unix
  ];

  checkInputs = [
    # tezos-test-helpers
  ];

  # circular dependency if we add this
  doCheck = false;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: meta-package and pervasive type definitions for Tezos";
    };
}

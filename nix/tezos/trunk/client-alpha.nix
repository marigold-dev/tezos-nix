{ lib, buildDunePackage, tezos-stdlib, tezos-mockup-registration, tezos-proxy
, tezos-signer-backends, tezos-alpha, alcotest-lwt, ppx_inline_test
, qcheck-alcotest, tezos-test-helpers, tezos-base-test-helpers, cacert }:

buildDunePackage {
  pname = "tezos-client-alpha";
  inherit (tezos-stdlib) version useDune2;
  src = "${tezos-stdlib.base_src}/src/proto_alpha/lib_client";

  propagatedBuildInputs = [
    tezos-mockup-registration
    tezos-proxy
    tezos-signer-backends
    tezos-alpha.protocol
    tezos-alpha.protocol-parameters
    tezos-alpha.protocol-plugin
    ppx_inline_test
  ];

  checkInputs = [
    alcotest-lwt
    qcheck-alcotest
    tezos-test-helpers
    tezos-base-test-helpers
    cacert
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos/Protocol: protocol specific library for `tezos-client`";
  };
}

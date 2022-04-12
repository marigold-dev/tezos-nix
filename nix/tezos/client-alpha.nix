{ lib, buildDunePackage, tezos-stdlib, tezos-mockup-registration, tezos-proxy
, tezos-signer-backends, tezos-alpha, alcotest-lwt, tezos-base-test-helpers
, ppx_inline_test, cacert }:

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
  ];

  checkInputs = [ alcotest-lwt tezos-base-test-helpers ppx_inline_test cacert ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos/Protocol: protocol specific library for `tezos-client`";
  };
}

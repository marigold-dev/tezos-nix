{
  lib,
  buildDunePackage,
  tezos-stdlib,
  ppx_expect,
  tezos-base,
  tezos-clic,
  tezos-shell-services,
  tezos-client-base,
  tezos-protocol-alpha,
  tezos-mockup-registration,
  tezos-proxy,
  tezos-signer-backends,
  tezos-protocol-plugin-alpha,
  tezos-rpc,
  uri,
  tezos-stdlib-unix,
  tezos-protocol-environment,
  tezos-mockup,
  tezos-mockup-commands,
  tezos-client-commands,
  tezos-client-base-unix,
  tezos-crypto,
  tezos-micheline,
  tezos-base-test-helpers,
  tezos-test-helpers,
  alcotest-lwt,
  qcheck-alcotest,
}:
buildDunePackage {
  pname = "tezos-client-alpha";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ppx_expect
    tezos-base
    tezos-clic
    tezos-shell-services
    tezos-client-base
    tezos-protocol-alpha
    tezos-mockup-registration
    tezos-proxy
    tezos-signer-backends
    tezos-protocol-plugin-alpha
    tezos-rpc
    uri
    tezos-stdlib-unix
    tezos-protocol-environment
    tezos-mockup
    tezos-mockup-commands
    tezos-client-commands
    tezos-client-base-unix
    tezos-crypto
  ];

  checkInputs = [
    tezos-micheline
    tezos-base-test-helpers
    tezos-test-helpers
    alcotest-lwt
    qcheck-alcotest
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos/Protocol: protocol specific library for Layer 2 utils";
    };
}

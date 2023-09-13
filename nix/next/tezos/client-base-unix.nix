{
  lib,
  buildDunePackage,
  octez-libs,
  tezos-client-base,
  lwt-exit,
  tezos-signer-backends,
  tezos-proxy,
  tezos-version,
  tezos-mockup-commands,
  alcotest-lwt,
  cacert,
}:
buildDunePackage {
  pname = "tezos-client-base-unix";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-version
    tezos-client-base
    lwt-exit
    tezos-signer-backends
    tezos-proxy
    tezos-mockup-commands
  ];

  checkInputs = [alcotest-lwt cacert];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

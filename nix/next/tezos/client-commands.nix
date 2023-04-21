{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-signer-backends,
  data-encoding,
  alcotest-lwt,
}:
buildDunePackage {
  pname = "tezos-client-commands";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [tezos-signer-backends data-encoding];

  checkInputs = [alcotest-lwt];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

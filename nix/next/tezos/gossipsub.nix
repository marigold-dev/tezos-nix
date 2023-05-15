{
  lib,
  buildDunePackage,
  ringo,
  aches,
  fmt,
  tezos-stdlib,
  tezos-stdlib-unix,
  tezos-error-monad,
  tezos-base,
  tezos-version,
}:
buildDunePackage {
  pname = "tezos-gossipsub";
  inherit (tezos-stdlib) version src postPatch;
  duneVersion = "3";

  propagatedBuildInputs = [
    ringo
    aches
    fmt
    tezos-stdlib
    tezos-stdlib-unix
    tezos-error-monad
    tezos-base
    tezos-version
  ];

  doCheck = true;

  meta = tezos-stdlib.meta // {description = "Tezos: event logging library";};
}

{ lib
, buildDunePackage
, tezos-stdlib
, tezos-client-base
, tezos-protocol-environment
}:

buildDunePackage {
  pname = "tezos-mockup-registration";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-client-base tezos-protocol-environment ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description = "Tezos: protocol registration for the mockup mode";
  };
}

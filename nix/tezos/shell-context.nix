{ lib, buildDunePackage, tezos-stdlib, tezos-protocol-environment }:

buildDunePackage {
  pname = "tezos-shell-context";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-protocol-environment ];

  doCheck = true;

  meta = tezos-stdlib.meta // {
    description =
      "Tezos: economic-protocols environment implementation for `tezos-node`";
  };
}

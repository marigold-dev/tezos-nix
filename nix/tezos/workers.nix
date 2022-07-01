{ lib, buildDunePackage, tezos-stdlib, tezos-base }:

buildDunePackage {
  pname = "tezos-workers";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-base ];

  doCheck = true;

  meta = tezos-stdlib.meta // { description = "Tezos: worker library"; };
}

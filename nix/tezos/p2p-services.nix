{ lib, buildDunePackage, tezos-stdlib, tezos-base }:

buildDunePackage {
  pname = "tezos-p2p-services";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [ tezos-base ];

  meta = tezos-stdlib.meta // {
    description = "Tezos: descriptions of RPCs exported by `tezos-p2p`";
  };
}

{
  lib,
  buildDunePackage,
  tezos-stdlib,
  tezos-lwt-result-stdlib,
  zarith,
}:
buildDunePackage {
  pname = "lazy-containers";
  inherit (tezos-stdlib) version;
  duneVersion = "3";
  src = "${tezos-stdlib.base_src}";

  propagatedBuildInputs = [
    tezos-lwt-result-stdlib
    zarith
  ];

  doCheck = true;

  meta =
    tezos-stdlib.meta
    // {
      description = "A collection of lazy containers whose contents is fetched from arbitrary backend on-demand";
    };
}

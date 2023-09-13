{ lib
, fetchpatch
, buildDunePackage
, octez-libs
, tezos-client-base
, tezos-shell
,
}:
buildDunePackage {
  pname = "octez-crawler";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    tezos-client-base
    tezos-shell
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez: library to crawl blocks of the L1 chain";
    };
}

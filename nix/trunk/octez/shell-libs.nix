{ lib
, buildDunePackage
, octez-libs
, lwt-watcher
, lwt-canceler
, ringo
, aches
, prometheus
, tezt
, octez-proto-libs
, octez-protocol-compiler
, lwt-exit
, tezos-version
, aches-lwt
, index
, irmin-pack
, camlzip
, tar
, tar-unix
, ppx_expect
, uri
, ocplib-endian
, fmt
, data-encoding
, resto-cohttp-self-serving-client
, tezos-benchmark
, octez-alcotezt
, astring
, qcheck-alcotest
, qcheck-core
, lwt
, tezt-tezos
}:
buildDunePackage rec {
  pname = "octez-shell-libs";

  inherit (octez-libs) src version;

  propagatedBuildInputs = [
    octez-libs
    lwt-watcher
    lwt-canceler
    ringo
    aches
    prometheus
    tezt
    octez-proto-libs
    octez-protocol-compiler
    lwt-exit
    tezos-version
    aches-lwt
    index
    irmin-pack
    camlzip
    tar
    tar-unix
    ppx_expect
    uri
    ocplib-endian
    fmt
    data-encoding
    resto-cohttp-self-serving-client
    tezos-benchmark
  ];

  checkInputs = [
    tezt-tezos
    octez-alcotezt
    astring
    qcheck-alcotest
    qcheck-core
    lwt
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Octez shell libraries";
    };
}

{ lib
, buildDunePackage
, ocamlPackages
, octez-libs
, cacert
, protocol-name
,
}:
let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  protocol_number = proto:
    if builtins.substring 0 4 proto == "demo"
    then -1
    else if proto == "alpha"
    then 1000
    else lib.toIntBase10 (builtins.substring 0 3 proto);
in
rec {
  libs = buildDunePackage {
    pname = "octez-protocol-${protocol-name}-libs";
    inherit (octez-libs) version src;

    nativeBuildInputs = [
      ocamlPackages.octez-protocol-compiler
    ];

    propagatedBuildInputs = with ocamlPackages; [
      protocol

      ppx_expect
      octez-libs
      octez-shell-libs
      uri
      qcheck-alcotest
      octez-proto-libs
      tezos-version
      tezos-dal-node-services
      lwt-canceler
      lwt-exit
      data-encoding
      octez-protocol-compiler
      tezos-dal-node-lib
      tezos-dac-lib
      tezos-dac-client-lib
      octez-injector
      octez-l2-libs
    ];

    checkInputs = with ocamlPackages; [
      tezt
      octez-alcotezt
      tezos-dac-node-lib
    ];

    doCheck = true;
  };

  protocol = buildDunePackage {
    pname = "tezos-protocol-${protocol-name}";
    inherit (octez-libs) version src;

    nativeBuildInputs = [ ocamlPackages.octez-protocol-compiler ];
    propagatedBuildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      octez-proto-libs
    ];

    doCheck = true;

    passthru.number = protocol_number protocol-name;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: economic-protocol definition";
      };
  };

  benchmark-type-inference = buildDunePackage {
    pname = "tezos-benchmark-type-inference-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      octez-libs
      tezos-micheline-rewriting
      protocol
      hashcons
      libs
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: library for writing benchmarks (protocol-specific part)";
      };
  };

  benchmark = buildDunePackage {
    pname = "tezos-benchmark-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      octez-libs
      tezos-micheline-rewriting

      tezos-benchmark
      benchmark-type-inference
      protocol
      libs

      hashcons
      prbnmcn-stats
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: library for writing benchmarks (protocol-specific part)";
      };
  };

  benchmarks = buildDunePackage {
    pname = "tezos-benchmarks-proto-${protocol-name}";
    inherit (octez-libs) version src;

    propagatedBuildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      octez-proto-libs

      tezos-benchmark

      protocol
      benchmark
      benchmark-type-inference
      libs
    ];

    doCheck = true;

    meta =
      octez-libs.meta
      // {
        description = "Tezos/Protocol: protocol benchmarks";
      };
  };
}

{ lib, buildDunePackage, ocamlPackages, tezos-stdlib, cacert, protocol-name }:

let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  src = "${tezos-stdlib.base_src}/src";
in rec {
  baking = buildDunePackage {
    pname = "tezos-baking-${protocol-name}";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-shell-context
      tezos-client-commands
      tezos-client-alpha
      lwt-exit
      tezos-client-base-unix
    ];

    checkInputs = with ocamlPackages; [
      tezos-base-test-helpers
      tezos-protocol-alpha-parameters
      alcotest-lwt
      tezos-alpha-test-helpers
      cacert
    ];

    # flaky
    doCheck = false;
  };

  commands = buildDunePackage {
    pname = "tezos-baking-${protocol-name}-commands";
    inherit (tezos-stdlib) version useDune2;
    inherit src;

    buildInputs = with ocamlPackages; [ baking ];

    doCheck = true;
  };
}

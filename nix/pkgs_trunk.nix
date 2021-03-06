{ pkgs
, stdenv
, lib
, fetchFromGitLab
, ocamlPackages
, zcash
, cacert
, static ? false
, doCheck
}:

let ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_13;

in
with ocamlPackages;

rec {
  trunk-tezos-client = buildDunePackage {
    pname = "tezos-client";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}/src/bin_client";

    propagatedBuildInputs = with ocamlPackages; [
      tezos-signer-backends
      tezos-client-base-unix

      tezos-alpha.client-commands-registration
      tezos-alpha.protocol-plugin
      tezos-alpha.baking-commands

      tezos-011-PtHangz2.client-commands-registration
      tezos-011-PtHangz2.protocol-plugin

      tezos-012-Psithaca.client-commands-registration
      tezos-012-Psithaca.protocol-plugin
      tezos-012-Psithaca.baking-commands

      tezos-013-PtJakart.client-commands-registration
      tezos-013-PtJakart.protocol-plugin
      tezos-013-PtJakart.baking-commands
    ];

    inherit doCheck;

    meta = { description = "Your service"; };
  };

  trunk-tezos-baker-alpha = buildDunePackage {
    pname = "tezos-baker-alpha";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}/src/proto_alpha/bin_baker";

    propagatedBuildInputs = with ocamlPackages; [
      tezos-alpha.protocol
      tezos-alpha.baking-commands
      tezos-alpha.baking
      tezos-alpha.client

      tezos-base
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-shell-services
      tezos-shell-context
      tezos-client-base
      tezos-client-base-unix
      tezos-mockup-commands
      tezos-rpc
    ];

    checkInputs = with ocamlPackages; [
      alcotest-lwt
      tezos-base-test-helpers
      cacert
    ];

    inherit doCheck;

    meta = { description = "Your service"; };
  };

  trunk-tezos-tx-rollup-node-alpha = buildDunePackage {
    pname = "tezos-tx-rollup-node-alpha";
    inherit (ocamlPackages.tezos-stdlib) version;

    src =
      "${ocamlPackages.tezos-stdlib.base_src}/src/proto_alpha/bin_tx_rollup_node";

    propagatedBuildInputs = with ocamlPackages; [
      tezos-base
      tezos-crypto
      tezos-alpha.protocol
      tezos-alpha.client
      tezos-client-commands
      tezos-context
      tezos-alpha.baking-commands
      tezos-alpha.baking
      tezos-stdlib-unix
      tezos-rpc
      tezos-rpc-http
      tezos-rpc-http-client-unix
      tezos-rpc-http-server
      tezos-micheline
      tezos-client-base
      tezos-client-base-unix
      tezos-store
    ];

    checkInputs = with ocamlPackages;
      [
        # alcotest-lwt
        # tezos-base-test-helpers
        # cacert
      ];

    inherit doCheck;

    meta = { description = "Your service"; };
  };

  trunk-tezos-node = ocamlPackages.buildDunePackage rec {
    pname = "tezos-node";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}/src/bin_node";

    buildInputs = with ocamlPackages; [
      tezos-base
      tezos-version
      tezos-rpc-http-server
      tezos-p2p
      tezos-shell
      tezos-workers
      tezos-protocol-updater
      tezos-validator
      tezos-alpha.embedded-protocol
      tezos-010-PtGRANAD.embedded-protocol
      tezos-011-PtHangz2.embedded-protocol
      tezos-012-Psithaca.embedded-protocol
      tezos-013-PtJakart.embedded-protocol
      tezos-010-PtGRANAD.protocol-plugin-registerer
      tezos-011-PtHangz2.protocol-plugin-registerer
      tezos-012-Psithaca.protocol-plugin-registerer
      tezos-013-PtJakart.protocol-plugin-registerer
      tezos-alpha.protocol-plugin-registerer
      tezos-010-PtGRANAD.protocol-plugin
      tezos-011-PtHangz2.protocol-plugin
      tezos-012-Psithaca.protocol-plugin
      tezos-013-PtJakart.protocol-plugin
      prometheus-app
      logs
      fmt
      cmdliner
      lwt-exit
      tls
      cstruct
    ];

    checkInputs = with ocamlPackages; [ tezos-base-test-helpers ];

    postInstall = ''
      patchShebangs tezos-sandboxed-node.sh
    '';

    doCheck = true;
  };

}

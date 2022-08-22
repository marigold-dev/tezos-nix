{ pkgs, stdenv, lib, fetchFromGitLab, zcash, cacert, static ? false, doCheck }:

let ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_14;

in
with ocamlPackages;

{
  tezos-client = buildDunePackage {
    pname = "tezos-client";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}";

    minimalOCamlVersion = "4.14";

    duneVersion = "3";

    buildInputs = with ocamlPackages; [
      tezos-signer-backends
      tezos-client-base-unix

      tezos-alpha.protocol-plugin
      tezos-alpha.baking-commands

      tezos-010-PtGRANAD.protocol
      tezos-010-PtGRANAD.protocol-plugin

      tezos-011-PtHangz2.protocol
      tezos-011-PtHangz2.protocol-plugin

      tezos-012-Psithaca.protocol
      tezos-012-Psithaca.protocol-plugin
      tezos-012-Psithaca.baking-commands

      tezos-013-PtJakart.protocol
      tezos-013-PtJakart.protocol-plugin
      tezos-013-PtJakart.baking-commands

      tezos-014-PtKathma.protocol
      tezos-014-PtKathma.protocol-plugin
      tezos-014-PtKathma.baking-commands
    ];

    inherit doCheck;

    meta = {
      description = "Your service";
      mainProgram = "tezos-client";
    };
  };

  tezos-baker-alpha = buildDunePackage {
    pname = "tezos-baker-alpha";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}";

    duneVersion = "3";

    buildInputs = with ocamlPackages; [
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

    meta = {
      description = "Your service";
      mainProgram = "tezos-baker-alpha";
    };
  };

  tezos-tx-rollup-node-alpha = buildDunePackage {
    pname = "tezos-tx-rollup-node-alpha";
    inherit (ocamlPackages.tezos-stdlib) version;
    src =
      "${ocamlPackages.tezos-stdlib.base_src}";

    duneVersion = "3";

    buildInputs = with ocamlPackages; [
      tezos-alpha.baking
      tezos-alpha.baking-commands
      tezos-alpha.client
      tezos-alpha.protocol
      tezos-base
      tezos-client-base
      tezos-client-base-unix
      tezos-client-commands
      tezos-context
      tezos-crypto
      tezos-micheline
      tezos-rpc
      tezos-rpc-http
      tezos-rpc-http-client-unix
      tezos-rpc-http-server
      tezos-stdlib-unix
      tezos-store
      tezos-tx-rollup-alpha
    ];

    checkInputs = with ocamlPackages;
      [
        # alcotest-lwt
        # tezos-base-test-helpers
        # cacert
      ];

    inherit doCheck;

    meta = {
      description = "Your service";
      mainProgram = "tezos-tx-rollup-node-alpha";
    };
  };

  tezos-node = ocamlPackages.buildDunePackage rec {
    pname = "tezos-node";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}";

    duneVersion = "3";

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
      tezos-000-Ps9mPmXa.embedded-protocol
      tezos-001-PtCJ7pwo.embedded-protocol
      tezos-002-PsYLVpVv.embedded-protocol
      tezos-003-PsddFKi3.embedded-protocol
      tezos-004-Pt24m4xi.embedded-protocol
      tezos-005-PsBABY5H.embedded-protocol
      tezos-005-PsBabyM1.embedded-protocol
      tezos-006-PsCARTHA.embedded-protocol
      tezos-007-PsDELPH1.embedded-protocol
      tezos-008-PtEdo2Zk.embedded-protocol
      tezos-009-PsFLoren.embedded-protocol
      tezos-010-PtGRANAD.embedded-protocol
      tezos-011-PtHangz2.embedded-protocol
      tezos-012-Psithaca.embedded-protocol
      tezos-013-PtJakart.embedded-protocol
      tezos-014-PtKathma.embedded-protocol
      tezos-010-PtGRANAD.protocol-plugin-registerer
      tezos-011-PtHangz2.protocol-plugin-registerer
      tezos-012-Psithaca.protocol-plugin-registerer
      tezos-013-PtJakart.protocol-plugin-registerer
      tezos-014-PtKathma.protocol-plugin-registerer
      tezos-alpha.protocol-plugin-registerer
      tezos-010-PtGRANAD.protocol-plugin
      tezos-011-PtHangz2.protocol-plugin
      tezos-012-Psithaca.protocol-plugin
      tezos-013-PtJakart.protocol-plugin
      tezos-014-PtKathma.protocol-plugin
      prometheus-app
      lwt-exit
      tls
      cstruct
    ];

    checkInputs = with ocamlPackages; [ tezos-base-test-helpers ];

    postInstall = ''
      patchShebangs tezos-sandboxed-node.sh
    '';

    doCheck = true;

    meta = {
      description = "Your service";
      mainProgram = "tezos-node";
    };
  };
}

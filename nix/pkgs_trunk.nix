{ pkgs, stdenv, lib, fetchFromGitLab, ocamlPackages, zcash, cacert, static ? false
, doCheck }:

with ocamlPackages;

rec {
  trunk-tezos-client = buildDunePackage {
    pname = "tezos-client";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}/src/bin_client";

    propagatedBuildInputs = with ocamlPackages; [
      tezos-signer-backends
      tezos-client-base-unix
    ];

    inherit doCheck;

    meta = { description = "Your service"; };
  };

  trunk-tezos-baker-alpha = buildDunePackage {
    pname = "tezos-baker-alpha";
    inherit (ocamlPackages.tezos-stdlib) version;
    src = "${ocamlPackages.tezos-stdlib.base_src}/src/proto_alpha/bin_baker";

    propagatedBuildInputs = with ocamlPackages; [
      tezos-base
      tezos-alpha.protocol
      tezos-baking-alpha.commands
      tezos-baking-alpha.baking
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-shell-services
      tezos-shell-context
      tezos-client-base
      tezos-client-base-unix
      tezos-client-alpha
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
    
    src = "${ocamlPackages.tezos-stdlib.base_src}/src/proto_alpha/bin_tx_rollup_node";

    propagatedBuildInputs = with ocamlPackages; [
      tezos-base
      tezos-crypto
      tezos-alpha.protocol
      tezos-client-alpha
      tezos-client-commands
      tezos-context
      tezos-baking-alpha.commands
      tezos-baking-alpha.baking
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

    checkInputs = with ocamlPackages; [
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
      tezos-genesis.embedded-protocol
      tezos-genesis-carthagenet.embedded-protocol
      tezos-demo-counter.embedded-protocol
      tezos-alpha.embedded-protocol
      tezos-demo-noops.embedded-protocol
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
      tezos-008-PtEdo2Zk.protocol-plugin-registerer
      tezos-009-PsFLoren.protocol-plugin-registerer
      tezos-010-PtGRANAD.protocol-plugin-registerer
      tezos-011-PtHangz2.protocol-plugin-registerer
      tezos-alpha.protocol-plugin-registerer
      tezos-010-PtGRANAD.protocol-plugin
      tezos-011-PtHangz2.protocol-plugin
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

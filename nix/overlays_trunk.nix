final: prev:
let
  version = "d6db6fa49429e6c94b674d91758276e8c9899a42";
  src = final.fetchFromGitLab {
    owner = "tezos";
    repo = "tezos";
    rev = version;
    sha256 = "sha256-+lcezeNlosVuFSdO7Ppk2+K0m6nXqhMBx1VHYiWVSMw=";
  };

in {
  ocaml-ng = builtins.mapAttrs (ocamlVersion: curr_ocaml:
    curr_ocaml.overrideScope' (oself: osuper:
      let
        callPackage = oself.callPackage;
        fix_platforms = package:
          package.overrideAttrs
          (_: { meta = { platforms = oself.ocaml.meta.platforms; }; });
      in {
        resto = fix_platforms osuper.resto;
        lwt-canceler = fix_platforms osuper.lwt-canceler;
        bisect_ppx = fix_platforms osuper.bisect_ppx;
        hacl-star-raw = osuper.hacl-star-raw.overrideAttrs
          (_: { hardeningDisable = [ "strictoverflow" ]; });

        repr = osuper.repr.overrideAttrs (o: rec {
          version = "0.6.0";
          src = final.fetchFromGitHub {
            owner = "mirage";
            repo = "repr";
            rev = version;
            sha256 = "sha256-jF8KmaG07CT26O/1ANc6s1yHFJqhXDtd0jgTA04tIgw=";
          };
        });

        irmin-test = osuper.irmin-test.overrideAttrs (o: rec {
          propagatedBuildInputs = with oself; [
            irmin
            ppx_irmin
            alcotest
            mtime
            astring
            fmt
            jsonm
            logs
            lwt
            metrics-unix
            ocaml-syntax-shims
            cmdliner
            metrics
          ];
        });

        irmin-pack = osuper.irmin-pack.overrideAttrs (o: rec {
          propagatedBuildInputs = with oself; [
            irmin
            ppx_irmin
            index
            fmt
            logs
            lwt
            mtime
            cmdliner
            optint
          ];
        });

        ppx_irmin = osuper.ppx_irmin.overrideAttrs (o: rec {
          version = "3.2.1";
          src = final.fetchFromGitHub {
            owner = "mirage";
            repo = "irmin";
            rev = version;
            sha256 = "sha256-StO8g3Ama1P1cUXvXwfa1E+uC6051Fah7cU517KkyAk=";
          };

          propagatedBuildInputs = o.propagatedBuildInputs
            ++ (with oself; [ logs ]);
        });

        irmin = osuper.irmin.overrideAttrs (o: rec {
          propagatedBuildInputs = o.propagatedBuildInputs
            ++ (with oself; [ mtime ]);
        });

        asetmap = final.stdenv.mkDerivation rec {
          version = "0.8.1";
          pname = "asetmap";
          src = final.fetchurl {
            url =
              "https://github.com/dbuenzli/asetmap/archive/refs/tags/v0.8.1.tar.gz";
            sha256 = "051ky0k62xp4inwi6isif56hx5ggazv4jrl7s5lpvn9cj8329frj";
          };

          strictDeps = true;

          nativeBuildInputs = with oself; [ topkg findlib ocamlbuild ocaml ];
          buildInputs = with oself; [ topkg ];

          inherit (oself.topkg) buildPhase installPhase;

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        prometheus = oself.buildDunePackage rec {
          version = "1.1.0";
          pname = "prometheus";
          src = final.fetchurl {
            url =
              "https://github.com/mirage/prometheus/releases/download/v1.1/prometheus-v1.1.tbz";
            sha256 = "1r4rylxmhggpwr1i7za15cpxdvgxf0mvr5143pvf9gq2ijr8pkzv";
          };

          strictDeps = true;

          propagatedBuildInputs = with oself; [
            astring
            asetmap
            fmt
            re
            lwt
            alcotest
          ];

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        prometheus-app = oself.buildDunePackage rec {
          pname = "prometheus-app";
          inherit (oself.prometheus) src version;

          strictDeps = true;

          propagatedBuildInputs = with oself; [
            logs
            fmt
            cohttp
            cohttp-lwt-unix
            cmdliner
            prometheus
          ];

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        ptime = osuper.ptime.overrideAttrs (o: rec {
          version = "1.0.0";
          src = final.fetchurl {
            url =
              "https://erratique.ch/software/ptime/releases/ptime-1.0.0.tbz";
            sha256 = "02qiwafysw5vpbxmkhgf6hfr5fv967rxzfkfy18kgj3206686724";
          };

          buildPhase = "${oself.topkg.run} build";
        });

        bls12-381 = osuper.bls12-381.overrideAttrs (o: rec {
          version = "3.0.1";
          src = final.fetchFromGitLab {
            owner = "dannywillems";
            repo = "ocaml-bls12-381";
            rev = version;
            sha256 = "sha256-ScKEkv+a83XJgcK9xiUqVQECoGT3PPx9stzz9QReu5I=";
          };

          propagatedBuildInputs = o.propagatedBuildInputs
            ++ (with oself; [ zarith_stubs_js integers_stubs_js integers hex ]);

          checkInputs = (with oself; [ alcotest ff-pbt ]);

          meta = { platforms = oself.ocaml.meta.platforms; };
        });

        ringo = osuper.ringo.overrideAttrs (o: rec {
          version = "0.8";
          src = final.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "ringo";
            rev = "v${version}";
            sha256 = "sha256-eRSlkIP6JJiOwcBracIiD2IeJYeZpHL5cOttCGKzgOI=";
          };

          meta = { platforms = oself.ocaml.meta.platforms; };
        });

        json-data-encoding = osuper.json-data-encoding.overrideAttrs (o: rec {
          version = "0.11";
          src = final.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = o.pname;
            rev = "${version}";
            sha256 = "sha256-4FNUU82sq3ylgw0lxHlwi1OV58NRRh9zJqE47YyQZSc=";
          };

          meta = { platforms = oself.ocaml.meta.platforms; };
        });

        json-data-encoding-bson = osuper.json-data-encoding-bson.overrideAttrs
          (o: rec {
            version = "0.11";
            src = oself.json-data-encoding.src;

            meta = { platforms = oself.ocaml.meta.platforms; };
          });

        data-encoding = osuper.data-encoding.overrideAttrs (o: rec {
          version = "0.5.3";
          src = final.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = o.pname;
            rev = "v${version}";
            sha256 = "sha256-HMNpjh5x7vU/kXQNRjJtOvShEENoNuxjNNPBJfm+Rhg=";
          };

          propagatedBuildInputs = o.propagatedBuildInputs
            ++ (with oself; [ either zarith_stubs_js ]);

          meta = { platforms = oself.ocaml.meta.platforms; };
        });

        integers_stubs_js = oself.buildDunePackage rec {
          pname = "integers_stubs_js";
          version = "1.0";
          src = final.fetchFromGitHub {
            owner = "o1-labs";
            repo = pname;
            rev = version;
            sha256 = "sha256-lg5cX9/LQlVmR42XcI17b6KaatnFO2L9A9ZXfID8mTY=";
          };

          propagatedBuildInputs = with oself; [ zarith_stubs_js js_of_ocaml ];

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        ctypes_stubs_js = oself.buildDunePackage rec {
          pname = "ctypes_stubs_js";
          version = "0.1";
          src = final.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = pname;
            rev = version;
            sha256 = "sha256-OJIzg2hnwkXkQHd4bRR051eLf4HNWa/XExxbj46SyUs=";
          };

          propagatedBuildInputs = with oself; [ integers_stubs_js ];

          checkInputs = with oself; [ ctypes ppx_expect ];

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        ometrics = oself.buildDunePackage rec {
          pname = "ometrics";
          version = "0.1.3";

          src = final.fetchurl {
            url =
              "https://github.com/vch9/ometrics/releases/download/0.1.3/ometrics-full.0.1.3.tar.gz";
            sha256 = "sha256-CLeHpyqZQo2TRj1SEdb9aKjbfdHTOpsHZOvbDgh8gnw=";
          };

          buildInputs = with oself; [
            yojson
            menhirSdk
            menhirLib
            menhir
            merlin
            csexp
            result
            cmdliner
            digestif
            bisect_ppx
          ];

          checkInputs = [ oself.qcheck-alcotest ];

          doCheck = false;

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        pure-splitmix = oself.buildDunePackage rec {
          pname = "pure-splitmix";
          version = "0.3";

          src = final.fetchFromGitHub {
            owner = "Lysxia";
            repo = pname;
            rev = version;
            sha256 = "RUnsAB4hMV87ItCyGhc47bHGY1iOwVv9kco2HxnzqbU=";
          };

          doCheck = true;

          meta = { platforms = oself.ocaml.meta.platforms; };
        };

        tezos-base = callPackage ./tezos/trunk/base.nix { };
        tezos-base-test-helpers =
          callPackage ./tezos/trunk/base-test-helpers.nix { };
        tezos-clic = callPackage ./tezos/clic.nix { };
        tezos-client-base = callPackage ./tezos/client-base.nix { };
        tezos-client-base-unix = callPackage ./tezos/client-base-unix.nix { };
        tezos-client-commands = callPackage ./tezos/client-commands.nix { };
        tezos-context = callPackage ./tezos/trunk/context.nix { };
        tezos-crypto = callPackage ./tezos/trunk/crypto.nix { };

        tezos-genesis = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "genesis";
          ocamlPackages = oself;
        };
        tezos-genesis-carthagenet =
          callPackage ./tezos/trunk/generic-protocol.nix {
            protocol-name = "genesis-carthagenet";
            ocamlPackages = oself;
          };
        tezos-demo-counter = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "demo-counter";
          ocamlPackages = oself;
        };
        tezos-demo-noops = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "demo-noops";
          ocamlPackages = oself;
        };
        tezos-000-Ps9mPmXa = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "000-Ps9mPmXa";
          ocamlPackages = oself;
        };
        tezos-001-PtCJ7pwo = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "001-PtCJ7pwo";
          ocamlPackages = oself;
        };
        tezos-002-PsYLVpVv = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "002-PsYLVpVv";
          ocamlPackages = oself;
        };
        tezos-003-PsddFKi3 = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "003-PsddFKi3";
          ocamlPackages = oself;
        };
        tezos-004-Pt24m4xi = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "004-Pt24m4xi";
          ocamlPackages = oself;
        };
        tezos-005-PsBABY5H = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "005-PsBABY5H";
          ocamlPackages = oself;
        };
        tezos-005-PsBabyM1 = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "005-PsBabyM1";
          ocamlPackages = oself;
        };
        tezos-006-PsCARTHA = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "006-PsCARTHA";
          ocamlPackages = oself;
        };
        tezos-007-PsDELPH1 = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "007-PsDELPH1";
          ocamlPackages = oself;
        };
        tezos-008-PtEdo2Zk = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "008-PtEdo2Zk";
          ocamlPackages = oself;
        };
        tezos-009-PsFLoren = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "009-PsFLoren";
          ocamlPackages = oself;
        };
        tezos-010-PtGRANAD = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "010-PtGRANAD";
          ocamlPackages = oself;
        };
        tezos-011-PtHangz2 = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "011-PtHangz2";
          ocamlPackages = oself;
        };
        tezos-012-Psithaca = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "012-Psithaca";
          ocamlPackages = oself;
        };
        tezos-013-PtJakart = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "013-PtJakart";
          ocamlPackages = oself;
        };
        tezos-alpha = callPackage ./tezos/trunk/generic-protocol.nix {
          protocol-name = "alpha";
          ocamlPackages = oself;
        };

        tezos-error-monad = callPackage ./tezos/error-monad.nix { };
        tezos-event-logging = callPackage ./tezos/event-logging.nix { };
        tezos-event-logging-test-helpers =
          callPackage ./tezos/event-logging-test-helpers.nix { };
        tezos-legacy-store = callPackage ./tezos/legacy-store.nix { };
        tezos-lmdb = callPackage ./tezos/lmdb.nix { };
        tezos-hacl = callPackage ./tezos/trunk/hacl.nix { };
        tezos-lwt-result-stdlib = callPackage ./tezos/lwt-result-stdlib.nix { };
        tezos-micheline = callPackage ./tezos/micheline.nix { };
        tezos-mockup-commands = callPackage ./tezos/mockup-commands.nix { };
        tezos-mockup-proxy = callPackage ./tezos/mockup-proxy.nix { };
        tezos-mockup-registration =
          callPackage ./tezos/mockup-registration.nix { };
        tezos-mockup = callPackage ./tezos/mockup.nix { };
        tezos-p2p-services = callPackage ./tezos/p2p-services.nix { };
        tezos-p2p = callPackage ./tezos/trunk/p2p.nix { };
        tezos-protocol-compiler = callPackage ./tezos/protocol-compiler.nix { };
        tezos-protocol-demo-noops =
          callPackage ./tezos/trunk/protocol-demo-noops.nix { };
        tezos-protocol-environment =
          callPackage ./tezos/trunk/protocol-environment.nix { };
        tezos-protocol-updater = callPackage ./tezos/protocol-updater.nix { };
        tezos-proxy = callPackage ./tezos/proxy.nix { };
        tezos-requester = callPackage ./tezos/requester.nix { };
        tezos-rpc-http-client-unix =
          callPackage ./tezos/rpc-http-client-unix.nix { };
        tezos-rpc-http-client = callPackage ./tezos/rpc-http-client.nix { };
        tezos-rpc-http-server = callPackage ./tezos/rpc-http-server.nix { };
        tezos-rpc-http = callPackage ./tezos/rpc-http.nix { };
        tezos-rpc = callPackage ./tezos/rpc.nix { };
        tezos-sapling = callPackage ./tezos/sapling.nix { };
        tezos-shell-context = callPackage ./tezos/shell-context.nix { };
        tezos-shell-services = callPackage ./tezos/shell-services.nix { };
        tezos-shell-services-test-helpers =
          callPackage ./tezos/shell-services-test-helpers.nix { };
        tezos-shell = callPackage ./tezos/shell.nix { };
        tezos-signer-backends = callPackage ./tezos/signer-backends.nix { };
        tezos-signer-services = callPackage ./tezos/signer-services.nix { };
        tezos-stdlib-unix = callPackage ./tezos/stdlib-unix.nix { };
        tezos-stdlib = callPackage ./tezos/stdlib.nix { inherit src version; };
        tezos-test-helpers = callPackage ./tezos/trunk/test-helpers.nix { };
        tezos-tooling = callPackage ./tezos/trunk/tooling.nix { };
        tezos-store = callPackage ./tezos/trunk/store.nix { };
        tezos-validation = callPackage ./tezos/validation.nix { };
        tezos-validator = callPackage ./tezos/validator.nix { };
        tezos-version = callPackage ./tezos/trunk/version.nix { };
        tezos-workers = callPackage ./tezos/workers.nix { };
      })) prev.ocaml-ng;
}

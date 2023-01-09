final: prev: {
  ocaml-ng =
    builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper: let
        inherit (oself) callPackage;
      in {
        data-encoding = osuper.data-encoding.overrideAttrs (_: rec {
          version = "0.7.1";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "data-encoding";
            rev = "v${version}";
            sha256 = "sha256-V3XiCCtoU+srOI+KVSJshtaSJLBJ4m4o10GpBfdYKCU=";
          };
        });

        bls12-381-hash = oself.buildDunePackage rec {
          pname = "bls12-381-hash";
          version = "1.0.0";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "cryptography/ocaml-bls12-381-hash";
            rev = "${version}";
            sha256 = "sha256-cfsSVmN4rbKcLcPcy6NduZktJhPXiVdK75LypmaSe9I=";
          };

          propagatedBuildInputs = [oself.bls12-381];
        };

        tezos-bls12-381-polynomial = osuper.tezos-bls12-381-polynomial.overrideAttrs (o: rec {
          version = "1.0.1";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "cryptography/privacy-team";
            rev = "v${version}";
            sha256 = "sha256-5qDa/fQoTypjaceQ0MBzt0rM+0hSJcpGlXMGAZKRboo=";
          };

          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.ppx_repr];
        });
        polynomial = oself.buildDunePackage rec {
          pname = "polynomial";
          version = "0.4.0";
          src = prev.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "cryptography/ocaml-polynomial";
            rev = version;
            sha256 = "sha256-is/PrYLCwStHiQsNq5OVRCwHdXjO2K2Z7FrXgytRfAU=";
          };

          propagatedBuildInputs = with oself; [zarith ff-sig];
        };
        tezos-plompiler = osuper.tezos-plompiler.overrideAttrs (o: rec {
          propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [polynomial bls12-381-hash]);
        });

        rusage = oself.buildDunePackage rec {
          pname = "rusage";
          version = "1.0.0";
          src = prev.fetchFromGitHub {
            owner = "CraigFe";
            repo = "ocaml-rusage";
            rev = version;
            sha256 = "sha256-Wswt3ETyiOFucCVSWZQN/YmL4rIdsyzPejSCiNrvqYw=";
          };
        };

        ppx_irmin = osuper.ppx_irmin.overrideAttrs (_: rec {
          version = "3.5.0";
          src = prev.fetchurl {
            url = "https://github.com/mirage/irmin/releases/download/${version}/irmin-${version}.tbz";
            sha256 = "sha256-mg2LB7go9cJElch5xbT280tNpQirQPM6lP7ylENkuCM=";
          };
        });

        irmin-pack = osuper.irmin-pack.overrideAttrs (o: rec {
          propagatedBuildInputs = o.propagatedBuildInputs ++ (with oself; [rusage checkseum]);
        });

        ringo = osuper.ringo.overrideAttrs (_: rec {
          version = "1.0.0";
          src = final.fetchFromGitLab {
            owner = "nomadic-labs";
            repo = "ringo";
            rev = "v${version}";
            sha256 = "sha256-9HW3M27BxrEPbF8cMHwzP8FmJduUInpQQAE2672LOuU=";
          };

          checkPhase = "dune build @test/ringo/runtest";
        });

        hacl-star-raw = callPackage ./hacl-star-raw.nix {};

        hacl-star = osuper.hacl-star.overrideAttrs (_: {
          buildInputs = [oself.alcotest];
        });

        aches = oself.buildDunePackage {
          pname = "aches";
          inherit (oself.ringo) src version;

          propagatedBuildInputs = [
            oself.ringo
          ];
        };

        aches-lwt = oself.buildDunePackage {
          pname = "aches-lwt";
          inherit (oself.ringo) src version;

          propagatedBuildInputs = [
            oself.aches
            oself.lwt
          ];
        };

        octez-node-config = callPackage ./tezos/node-config.nix {};
        tezos-layer2-utils-alpha = callPackage ./tezos/layer2-utils-alpha.nix {};
        tezos-protocol-environment = osuper.tezos-protocol-environment.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [
            tezos-stdlib
            tezos-crypto
            tezos-crypto-dal
            tezos-lwt-result-stdlib
            tezos-scoru-wasm

            data-encoding
            bls12-381
            tezos-plonk
            zarith
            zarith_stubs_js
            class_group_vdf
            ringo
            aches-lwt

            tezos-base
            tezos-sapling
            tezos-micheline
            tezos-context
            tezos-event-logging
          ];
        });
        tezos-proxy = osuper.tezos-proxy.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [tezos-mockup-proxy tezos-context];
        });
        tezos-store = osuper.tezos-store.overrideAttrs (o: {
          propagatedBuildInputs = with oself; [
            index
            camlzip
            tar-unix
            digestif
            lwt-watcher
            tezos-protocol-updater
            tezos-validation
            prometheus
          ];
        });

        tezos-016-PtMumbai = callPackage ../release/tezos/generic-protocol.nix {
          protocol-name = "016-PtMumbai";
          ocamlPackages = oself;
        };
        tezos-alpha =
          osuper.tezos-alpha
          // {
            injector = osuper.tezos-alpha.injector.overrideAttrs (o: {
              propagatedBuildInputs =
                o.propagatedBuildInputs
                ++ [
                  oself.tezos-layer2-utils-alpha
                ];
            });
          };
        tezos-stdlib = osuper.tezos-stdlib.overrideAttrs (o: {
          propagatedBuildInputs = o.propagatedBuildInputs ++ [oself.aches];
        });
      }))
    prev.ocaml-ng;
}

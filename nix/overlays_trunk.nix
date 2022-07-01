final: prev:

{
  ocaml-ng = builtins.mapAttrs
    (ocamlVersion: curr_ocaml:
      curr_ocaml.overrideScope' (oself: osuper:
        let
          callPackage = oself.callPackage;
          fix_platforms = package:
            package.overrideAttrs
              (_: { meta = { platforms = oself.ocaml.meta.platforms; }; });
        in
        {
          secp256k1-internal = osuper.secp256k1-internal.overrideAttrs (_: rec {
            version = "0.3";
            src = final.fetchFromGitLab {
              owner = "nomadic-labs";
              repo = "ocaml-secp256k1-internal";
              rev = version;
              sha256 = "sha256-1wvQ4RW7avcGsIc0qgDzhGrwOBY0KHrtNVHCj2cgNzo=";
            };
          });
          bls12-381 = osuper.bls12-381.overrideAttrs (o: rec {
            version = "4.0.0";
            src = final.fetchFromGitLab {
              owner = "dannywillems";
              repo = "ocaml-bls12-381";
              rev = version;
              sha256 = "sha256-K9AsYUAUdk4XnspUalJKX5kycDFwO8PZx4bGaD3qZv8=";
            };

            propagatedBuildInputs = o.propagatedBuildInputs
              ++ (with oself; [ zarith_stubs_js integers_stubs_js integers hex ]);

            checkInputs = (with oself; [ alcotest ff-pbt ]);

            meta = { platforms = oself.ocaml.meta.platforms; };
          });
          tezos-bls12-381-polynomial = callPackage ./tezos/trunk/bls12-381-polynomial.nix { };
          tezos-stdlib = osuper.tezos-stdlib.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-stdlib-unix = osuper.tezos-stdlib-unix.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-error-monad = osuper.tezos-error-monad.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-rpc = osuper.tezos-rpc.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-micheline = osuper.tezos-micheline.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-event-logging = osuper.tezos-event-logging.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-event-logging-test-helpers = osuper.tezos-event-logging-test-helpers.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-hacl = osuper.tezos-hacl.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-clic = osuper.tezos-clic.overrideAttrs (_: {
            buildInputs = [ oself.ppx_expect ];
          });
          tezos-crypto = osuper.tezos-crypto.overrideAttrs (o: {
            propagatedBuildInputs = o.propagatedBuildInputs ++ [ oself.tezos-bls12-381-polynomial ];
            buildInputs = [ oself.ppx_expect ];
          });
        }))
    prev.ocaml-ng;
}

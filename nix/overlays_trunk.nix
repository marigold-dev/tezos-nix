final: prev:
let
  version = "2002-06-16";
  src = final.fetchFromGitLab {
    owner = "tezos";
    repo = "tezos";
    rev = "e5fc6367e0130db788dde5d7b6c51ee946042678";
    sha256 = "sha256-RHvd7RLMVu3kp7f7Ig+1Og8StxmRSJi9+IFJ7D4Kv6c=";
  };

in
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
          tezos-stdlib = callPackage ./tezos/stdlib.nix { inherit src version; };
        }))
    prev.ocaml-ng;
}

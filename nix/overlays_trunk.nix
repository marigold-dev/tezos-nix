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
        { }))
    prev.ocaml-ng;
}

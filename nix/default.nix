{ pkgs ? import ./sources.nix { }, doCheck ? false, src, version }:

{
  native = pkgs.callPackage ./generic.nix { inherit doCheck src version; };

  musl64 = let pkgsCross = pkgs.pkgsCross.musl64.pkgsStatic;

  in pkgsCross.callPackage ./generic.nix {
    static = true;
    inherit doCheck src version;
    ocamlPackages = pkgsCross.ocamlPackages;
  };
}

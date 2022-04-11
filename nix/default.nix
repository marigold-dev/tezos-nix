{ pkgs ? import ./sources.nix { }, doCheck ? false }:

{
  native = pkgs.callPackage ./pkgs.nix { inherit doCheck; };

  musl64 = let pkgsCross = pkgs.pkgsCross.musl64.pkgsStatic;

  in pkgsCross.callPackage ./pkgs.nix {
    static = true;
    inherit doCheck;
    ocamlPackages = pkgsCross.ocamlPackages;
  };
}

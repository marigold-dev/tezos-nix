{
  self,
  inputs,
  ...
}: let
  overlay = import ./overlays.nix;
  version = {
    octez_version = "20230316";
    src = inputs.tezos_trunk;
  };
in {
  flake = {
    overlays = {trunk = overlay;};
  };

  perSystem = {
    config,
    self',
    inputs',
    system,
    ...
  }: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (self.overlays.release version)
        self.overlays.trunk
      ];
    };
    tezos_pkgs = pkgs.callPackage ./pkgs.nix {doCheck = true;};
    l = pkgs.lib // builtins;
    packages = builtins.removeAttrs tezos_pkgs [
      "override"
      "overrideDerivation"
    ];
  in {
    inherit packages;
    devShells.dev = let
      collectInputs = topInputs:
        l.foldAttrs
        (
          item: accum:
            l.unique (item ++ accum)
        )
        []
        (l.map (l.filterAttrs (k: _: l.hasSuffix "Inputs" k)) topInputs);

      topLevelInputs = collectInputs (l.attrValues packages);

      inputs = let
        isTezosPackage = drv: let
          name = l.getName drv;
        in
          l.hasPrefix "tezos-" name || l.hasPrefix "octez-" name || l.hasPrefix "tezt-" name;

        recurseInputs = topInputs: olAccum: let
          accum =
            l.mapAttrs
            (k: v:
              (l.filter (i: !isTezosPackage i)) (v ++ (olAccum.${k} or [])))
            (l.mapAttrs (_: l.filter (i: !isTezosPackage i)) topInputs);
          tezosPackages = l.filter isTezosPackage (l.flatten (l.attrValues topInputs));
          newInputs = collectInputs tezosPackages;
          inputContainsTezosPkg = l.filter isTezosPackage (l.flatten (l.attrValues newInputs)) != [];
        in
          if inputContainsTezosPkg
          then recurseInputs newInputs accum
          else l.mapAttrs (k: v: v ++ (accum.${k} or [])) newInputs;
      in
        recurseInputs topLevelInputs {};
    in
      pkgs.mkShell {
        name = "tezos-dev";
        inputsFrom = [inputs];
        nativeBuildInputs = with pkgs;
          [nodejs python311 dune_3]
          ++ (with pkgs.ocamlPackages; [ocaml findlib js_of_ocaml]);
        buildInputs =
          [pkgs.tezos-rust-libs]
          ++ (with pkgs.ocamlPackages; [hashcons tezt tezos-plompiler tezos-plonk pyml ppx_import ocaml-lsp]);

        shellHook = ''
          export OPAM_SWITCH_PREFIX="${pkgs.tezos-rust-libs}"
          export TEZOS_WITHOUT_OPAM=true

          echo "Don't forget to run npm install, happy hacking!"
        '';
      };
  };
}

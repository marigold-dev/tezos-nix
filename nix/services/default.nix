{ self
, inputs
, ...
}: {
  flake = {
    nixosModules = {
      tezos-baking = import ./baking.nix {
        nodePackage = self.packages.octez-node;
        bakerPackage = self.packages.octez-baker-PtMumbai;
        accuserPackage = self.packages.octez-accuser-PtMumbai;
      };
    };
  };
}

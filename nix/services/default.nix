{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules = {
      x86_64-linux_tezos-baking = import ./baking.nix {
        nodePackage = self.packages.x86_64-linux.octez-node;
        bakerPackage = self.packages.x86_64-linux.octez-baker-PtMumbai;
        accuserPackage = self.packages.x86_64-linux.octez-accuser-PtMumbai;
      };
      aarch64-linux_tezos-baking = import ./baking.nix {
        nodePackage = self.packages.aarch64-linux.octez-node;
        bakerPackage = self.packages.aarch64-linux.octez-baker-PtMumbai;
        accuserPackage = self.packages.aarch64-linux.octez-accuser-PtMumbai;
      };
    };
  };
}

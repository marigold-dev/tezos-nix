{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules = {
      x86_64-linux_tezos-node = import ./node.nix {
        inherit (self.packages.x86_64-linux) octez-node tezos-node-bootstrapper;
      };
      aarch64-linux_tezos-node = import ./node.nix {
        inherit (self.packages.aarch64-linux) octez-node tezos-node-bootstrapper;
      };
      x86_64-linux_tezos-baking = import ./baking.nix {
        bakerPackage = self.packages.x86_64-linux.octez-baker-PtMumbai;
        accuserPackage = self.packages.x86_64-linux.octez-accuser-PtMumbai;
      };
      aarch64-linux_tezos-baking = import ./baking.nix {
        bakerPackage = self.packages.aarch64-linux.octez-baker-PtMumbai;
        accuserPackage = self.packages.aarch64-linux.octez-accuser-PtMumbai;
      };
    };
  };
}

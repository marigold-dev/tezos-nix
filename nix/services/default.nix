{ self
, inputs
, ...
}: {
  flake = {
    nixosModules = {
      tezos-baking = import ./baking.nix { };
    };
  };
}

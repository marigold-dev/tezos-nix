{
  pkgs,
  nix2container,
}: {
  dac-node = {
    name,
    octez-client,
    octez-dac-node,
    octez-dac-client,
    octez-dal-node,
    octez-smart-rollup-node-alpha,
    octez-smart-rollup-node-PtNairob,
  }:
    nix2container.buildImage {
      inherit name;
      copyToRoot = [
        (pkgs.buildEnv {
          name = "root";
          paths = [pkgs.bashInteractive pkgs.coreutils];
          pathsToLink = ["/bin"];
        })
        (pkgs.buildEnv {
          name = "root";
          paths = [
            octez-client
            octez-dac-node
            octez-dac-client
            octez-dal-node
            octez-smart-rollup-node-alpha
            octez-smart-rollup-node-PtNairob
          ];
          pathsToLink = ["/bin"];
        })
      ];
      maxLayers = 5;
      config = {
        Cmd = ["/bin/bash"];
      };
    };
}

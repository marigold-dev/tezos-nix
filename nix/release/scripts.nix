{
  pkgs,
  octez-node,
}: {
  tezos-node-configurator = pkgs.writeShellApplication {
    name = "tezos-node-configurator.sh";
    runtimeInputs = with pkgs; [curl octez-node wget];
    text = ''
      ${builtins.readFile ./tezos-node-configurator.sh}
    '';
  };

  tezos-snapshot-downloader = pkgs.writeShellApplication {
    name = "tezos-snapshot-downloader.sh";
    runtimeInputs = with pkgs; [curl octez-node];
    text = ''
      ${builtins.readFile ./tezos-snapshot-downloader.sh}
    '';
  };

  tezos-node-bootstrapper = pkgs.writeShellApplication {
    name = "tezos-node-bootstrapper.sh";
    runtimeInputs = with pkgs; [curl octez-node wget];
    text = ''
      ${builtins.readFile ./tezos-node-bootstrapper.sh}
    '';
  };
}

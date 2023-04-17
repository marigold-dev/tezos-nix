{
  pkgs,
  octez-node,
}: {
  tezos-node-configurator = pkgs.writeShellApplication {
    name = "tezos-node-configurator.sh";
    runtimeInputs = with pkgs; [curl octez-node];
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
}

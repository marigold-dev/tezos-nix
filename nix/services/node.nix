{octez-node}: {
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.tezos-node;
  node_pkg = cfg.nodePackage;
  port = builtins.toString cfg.port;
  endpoint =
    if cfg.bind != null
    then "${cfg.bind}:${port}"
    else "0.0.0.0:${port}";
in {
  options.services.tezos-node = {
    enable = mkEnableOption "Tezos Node";

    port = mkOption {
      type = types.int;
      default = 8732;
      description = lib.mDoc "The port for the tezos node to listen on";
    };

    bind = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = lib.mdDoc ''
        The IP interface to bind to.
        `null` means "all interfaces".
      '';
    };

    nodePackage = mkOption {
      type = types.package;
      default = octez-node;
      defaultText = literalExpression "pkgs.octez-node";
      description = lib.mdDoc "The Tezos Node package to use.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc "Open ports in the firewall for the tezos node.";
    };

    historyMode = mkOption {
      type = types.str;
      default = "rolling";
      description = lib.mdDoc "What history mode to run in, valid values are `rolling`, `full` and `archive`";
    };

    tezosNetwork = mkOption {
      type = types.str;
      default = "mainnet";
      description = lib.mdDoc "What network to target";
    };

    snapshotUrl = mkOption {
      type = types.str;
      default = "https://snapshots.tezos.marigold.dev/api/mainnet/${cfg.tezosNetwork}";
      description = lib.mdDoc "Where to get snapshots";
    };
  };

  config = mkIf cfg.enable {
    systemd = {
      services = {
        tezos-node = {
          description = "Tezos Node Service";
          documentation = ["http://tezos.gitlab.io/"];
          wants = ["network.target"];
          after = ["network.target"];
          wantedBy = ["multi-user.target"];
          requiredBy = ["tezos-baker.service" "tezos-accuser.service"];
          serviceConfig = {
            Type = "simple";
            ExecStart = ''
              ${node_pkg}/bin/octez-node run \
                --rpc-addr ${endpoint} \
                --data-dir /run/tezos/.octez-node \
                --history-mode ${cfg.historyMode} \
                --network ${cfg.tezosNetwork}
            '';
            Restart = "on-failure";
            StateDirectory = "tezos";
            RuntimeDirectory = "tezos";
            RuntimeDirectoryPreserve = "yes";
          };
        };
      };
    };
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [
        cfg.port
      ];
    };
  };
}

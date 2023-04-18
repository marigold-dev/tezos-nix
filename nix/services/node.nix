{
  octez-node,
  tezos-node-bootstrapper,
}: {
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.tezos-node;
  node_pkg = cfg.package;
  bootstrap_pkg = cfg.bootstrapPackage;
  port = builtins.toString cfg.port;
  data_dir = "/run/tezos/.octez-node";
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

    package = mkOption {
      type = types.package;
      default = octez-node;
      defaultText = literalExpression "pkgs.octez-node";
      description = lib.mdDoc "The Tezos Node package to use.";
    };

    bootstrapPackage = mkOption {
      type = types.package;
      default = tezos-node-bootstrapper;
      defaultText = literalExpression "pkgs.tezos-node-bootstrap";
      description = lib.mdDoc "The bootstrap script to run.";
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
          environment = {
            TEZOS_NETWORK = cfg.tezosNetwork;
            SNAPSHOT_URL = cfg.snapshotUrl;
            HISTORY_MODE = cfg.historyMode;
          };
          serviceConfig = mkMerge [
            {
              Type = "simple";
              ExecStart = ''
                ${node_pkg}/bin/octez-node run \
                  --rpc-addr ${endpoint} \
                  --data-dir ${data_dir} \
                  --history-mode ${cfg.historyMode} \
                  --network ${cfg.tezosNetwork}
              '';
              Restart = "on-failure";
              StateDirectory = "tezos";
              RuntimeDirectory = "tezos";
              RuntimeDirectoryPreserve = "yes";
            }
            (mkIf (cfg.snapshotUrl != null) {
              ExecStartPre = "${bootstrap_pkg}/bin/tezos-node-bootstrapper.sh ${data_dir}";
            })
          ];
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

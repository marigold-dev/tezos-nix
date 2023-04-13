{ nodePackage
, bakerPackage
, accuserPackage
}:
{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.services.tezos-node;
  node_pkg = cfg.nodePackage;
  baker_pkg = cfg.bakerPackage;
  accuser_pkg = cfg.accuserPackage;
in
{
  options.services.tezos-baking = {
    enable = mkEnableOption "Tezos Baking";
    port = mkOption {
      type = types.int;
      default = 8732;
      description = lib.mDoc "The port for the tezos node to listen on";
    };

    # TODO: Move the node to separate option
    nodePackage = mkOption {
      type = types.package;
      default = nodePackage;
      defaultText = literalExpression "pkgs.octez-node";
      description = lib.mdDoc "The Tezos Node package to use.";
    };

    bakerPackage = mkOption {
      type = types.package;
      default = bakerPackage;
      defaultText = literalExpression "pkgs.octez-baker";
      description = lib.mdDoc "The Tezos Baker package to use.";
    };

    accuserPackage = mkOption {
      type = types.package;
      default = accuserPackage;
      defaultText = literalExpression "pkgs.octez-accuser";
      description = lib.mdDoc "The Tezos Accuser package to use.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc "Open ports in the firewall for the tezos node.";
    };
  };

  config = mkIf cfg.enable {
    systemd = {
      services = {
        tezos-node = {
          description = "Tezos Node Service";
          documentation = "http://tezos.gitlab.io/";
          wants = [ "network.target" ];
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          requiredBy = [ "tezos-baker.service" "tezos-accuser.service" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${node_pkg}/bin/octez-node --rpc-addr 127.0.0.1:${cfg.port} --data-dir /run/tezos/.octez-node";
            Restart = "on-failure";
            StateDirectory = "tezos";
            RuntimeDirectory = "tezos";
            RuntimeDirectoryPreserve = "yes";
          };
        };

        tezos-baker = {
          description = "Tezos baker Service";
          documentation = "http://tezos.gitlab.io/";
          wants = [ "network.target" ];
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          requires = [ "tezos-node.service" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${baker_pkg}/bin/${baker_pkg.pname} --endpoint http://127.0.0.1:${cfg.port} run with local node /run/tezos/.octez-node --liquidity-baking-toggle-vote on";
            Restart = "on-failure";
            StateDirectory = "tezos";
            RuntimeDirectory = "tezos";
            RuntimeDirectoryPreserve = "yes";
          };
        };

        tezos-accuser = {
          description = "Tezos accuser Service";
          documentation = "http://tezos.gitlab.io/";
          wants = [ "network.target" ];
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          requires = [ "tezos-node.service" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${accuser_pkg}/bin/${accuser_pkg.pname} --endpoint http://127.0.0.1:${cfg.port} run";
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

{
  bakerPackage,
  accuserPackage,
}: {
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.tezos-baking;
  baker_pkg = cfg.bakerPackage;
  accuser_pkg = cfg.accuserPackage;
  port = builtins.toString cfg.port;
in {
  options.services.tezos-baking = {
    enable = mkEnableOption "Tezos Baking";

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

    runNode = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc "Runs a Tezos node to use with the baker and accuser.";
    };

    nodeEndpoint = mkOption {
      type = types.str;
      default = "http://127.0.0.1:8732";
      description = lib.mdDoc "Endpoint to use for the Tezos Node.";
    };

    tezosNetwork = mkOption {
      type = types.str;
      default = "mainnet";
      description = lib.mdDoc "What network to target";
    };

    keyAlias = mkOption {
      type = types.str;
      description = lib.mdDoc "The baker ";
    };
  };

  config =
    lib.mkIf cfg.enable
    (mkMerge [
      {
        systemd = {
          services = {
            tezos-baker = {
              description = "Tezos baker Service";
              documentation = ["http://tezos.gitlab.io/"];
              wants = ["network.target"];
              after = ["network.target"];
              wantedBy = ["multi-user.target"];
              requires = ["tezos-node.service"];
              serviceConfig = {
                Type = "simple";
                ExecStart = "${baker_pkg}/bin/${baker_pkg.pname} --endpoint ${cfg.nodeEndpoint} run with local node /run/tezos/.octez-node ${cfg.keyAlias} --liquidity-baking-toggle-vote pass";
                Restart = "on-failure";
                StateDirectory = "tezos";
                RuntimeDirectory = "tezos";
                RuntimeDirectoryPreserve = "yes";
              };
            };

            tezos-accuser = {
              description = "Tezos accuser Service";
              documentation = ["http://tezos.gitlab.io/"];
              wants = ["network.target"];
              after = ["network.target"];
              wantedBy = ["multi-user.target"];
              requires = ["tezos-node.service"];
              serviceConfig = {
                Type = "simple";
                ExecStart = "${accuser_pkg}/bin/${accuser_pkg.pname} --endpoint ${cfg.nodeEndpoint} run";
                Restart = "on-failure";
                StateDirectory = "tezos";
                RuntimeDirectory = "tezos";
                RuntimeDirectoryPreserve = "yes";
              };
            };
          };
        };
      }
      (
        lib.mkIf cfg.runNode {
          services.tezos-node = {
            enable = true;
          };
        }
      )
    ]);
}

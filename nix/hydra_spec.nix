{ lib }:

{
  hydra-spec = lib.generators.toJSON { } {
    "enabled" = 1;
    "hidden" = false;
    "description" = "Build tezos bins";
    "flake_uri" = " 	github:marigold-dev/tezos-nix";
    "checkinterval" = 300;
    "schedulingshares" = 100;
    "enableemail" = false;
    "emailoverride" = "";
    "keepnr" = 3;
  };
}

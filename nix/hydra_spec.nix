{ lib }:

{
  hydra-spec = lib.generators.toJSON { } {
    "enabled" = 1;
    "hidden" = false;
    "description" = "PR \${num}: \${info.title}";
    "flake" = "github:marigold-dev/tezos-nix";
    "checkinterval" = 30;
    "schedulingshares" = 100;
    "enableemail" = false;
    "emailoverride" = "";
    "keepnr" = 3;
    "inputs" = {
      "pulls" = { "type" = "githubpulls"; "value" = "marigold-dev tezos-nix"; "emailresponsible" = false; };
    };
  };
}

{ nixpkgs, pull_requests }:

let
  pkgs = import nixpkgs { };
  json = builtins.toJSON {
    "checkinterval" = 30;
    # "description" = "PR ${pull_requests.num}: ${pull_requests.info.title}";
    "emailoverride" = "";
    "enabled" = 1;
    "enableemail" = false;
    "flake_uri" = "github:marigold-dev/tezos-nix";
    "hidden" = false;
    "inputs" = {
      "pulls" = {
        "emailresponsible" = false;
        "type" = "githubpulls";
        "value" = "marigold-dev tezos-nix";
      };
    };
    "keepnr" = 3;
    "schedulingshares" = 100;
  };
in { jobsets = pkgs.runCommand "jobsets.json" { } "echo ${json} > $out"; }

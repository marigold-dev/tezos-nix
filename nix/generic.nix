{ pkgs, stdenv, lib, fetchFromGitLab, ocamlPackages, static ? false, doCheck
, src, version }:

with ocamlPackages;

rec {
  tezos-client = buildDunePackage {
    pname = "tezos-client";

    inherit src version;

    postPatch = "rm -rf vendors";

    propagatedBuildInputs = with ocamlPackages;
      [
        tezos-signer-backends
        tezos-client-base-unix
      ];

    inherit doCheck;

    meta = { description = "Your service"; };
  };
}

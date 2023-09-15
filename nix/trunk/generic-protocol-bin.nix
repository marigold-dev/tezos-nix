{ lib
, buildDunePackage
, cacert
, ocamlPackages
, octez-libs
, protocol-name
, protocol-libs
, doCheck
,
}:
let
  underscore_name = builtins.replaceStrings [ "-" ] [ "_" ] protocol-name;
  protocol_number = proto:
    if builtins.substring 0 4 proto == "demo"
    then -1
    else if proto == "alpha"
    then 1000
    else lib.toIntBase10 (builtins.substring 0 3 proto);
in
rec {
  "trunk-octez-accuser-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-accuser-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      protocol-libs.protocol
      protocol-libs.libs
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} accuser binary";
      mainProgram = pname;
    };
  };

  "trunk-octez-baker-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-baker-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      protocol-libs.protocol
      protocol-libs.libs
    ];

    checkInputs = with ocamlPackages; [
      cacert
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} baker binary";
      mainProgram = pname;
    };
  };

  "trunk-octez-smart-rollup-client-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-client-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages; [
      octez-libs
      octez-shell-libs
      protocol-libs.protocol
      protocol-libs.libs
      octez-l2-libs
      tezos-version
    ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} Smart Rollup client binary";
      mainProgram = pname;
    };
  };

  "trunk-octez-smart-rollup-node-${protocol-name}" = ocamlPackages.buildDunePackage rec {
    pname = "octez-smart-rollup-node-${protocol-name}";
    inherit (octez-libs) version src;

    buildInputs = with ocamlPackages;
      [
        octez-libs
        octez-shell-libs
        protocol-libs.protocol
        protocol-libs.libs

        tezos-dal-node-services
        tezos-dal-node-lib
        tezos-dac-lib
        tezos-dac-client-lib
        octez-l2-libs
        octez-crawler
        data-encoding
        irmin-pack
        irmin
        aches
        aches-lwt
        octez-injector
        octez-smart-rollup-node-lib
        tezos-version
      ];

    inherit doCheck;

    meta = {
      description = "Protocol ${protocol-name} Smart Rollup node binary";
      mainProgram = pname;
    };
  };
}

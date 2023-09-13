{ lib
, buildDunePackage
, octez-libs
, uri
, qcheck-alcotest
, tezt
, octez-alcotezt
,
}:
buildDunePackage {
  pname = "tezos-proxy-server-config";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [
    octez-libs
    uri
  ];

  checkInputs = [
    tezt
    qcheck-alcotest
    octez-alcotezt
  ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: proxy server configuration";
    };
}

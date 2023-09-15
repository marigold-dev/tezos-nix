{ lib
, buildDunePackage
, octez-libs
, tezos-alpha
, zarith
, zarith_stubs_js
, tezt
,
}:
buildDunePackage {
  pname = "tezos-micheline-rewriting";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [ zarith zarith_stubs_js octez-libs ];

  checkInputs = [ tezos-alpha.protocol tezos-alpha.libs tezt ];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: library for rewriting Micheline expressions";
    };
}

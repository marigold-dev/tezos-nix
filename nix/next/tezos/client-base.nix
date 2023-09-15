{
  lib,
  buildDunePackage,
  octez-libs,
  tezt,
  octez-alcotezt,
}:
buildDunePackage {
  pname = "tezos-client-base";
  inherit (octez-libs) version src;
  
  propagatedBuildInputs = [octez-libs];

  checkInputs = [tezt octez-alcotezt];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: protocol registration for the mockup mode";
    };
}

{
  lib,
  buildDunePackage,
  octez-libs,
  dune-configurator,
}:
buildDunePackage {
  pname = "tezos-version";
  inherit (octez-libs) version src;

  propagatedBuildInputs = [octez-libs dune-configurator];

  doCheck = true;

  meta =
    octez-libs.meta
    // {
      description = "Tezos: version information generated from Git";
    };
}

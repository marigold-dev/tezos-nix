{
  lib,
  buildDunePackage,
  fetchFromGitLab,
  zarith,
  zarith_stubs_js ? null,
  integers_stubs_js,
  integers,
  hex,
  alcotest,
}:
buildDunePackage rec {
  pname = "bls12-381";
  version = "6.1.0";
  src = fetchFromGitLab {
    owner = "nomadic-labs";
    repo = "cryptography/ocaml-bls12-381";
    rev = version;
    sha256 = "sha256-z2ZSOrXgm+XjdrY91vqxXSKhA0DyJz6JkkNljDZznX8=";
  };

  minimalOCamlVersion = "4.08";
  duneVersion = "3";

  postPatch = ''
    patchShebangs ./src/*.sh
  '';

  propagatedBuildInputs = [
    zarith
    hex
    integers
  ];

  checkInputs = [
    zarith_stubs_js
    integers_stubs_js
    alcotest
  ];

  doCheck = true;

  meta = {
    homepage = "https://gitlab.com/dannywillems/ocaml-bls12-381";
    description = "OCaml binding for bls12-381 from librustzcash";
    license = lib.licenses.mit;
    maintainers = [lib.maintainers.ulrikstrid];
  };
}

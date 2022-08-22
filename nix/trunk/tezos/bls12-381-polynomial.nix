{ lib
, fetchFromGitLab
, buildDunePackage
, bls12-381
, data-encoding
, mec
, alcotest
, alcotest-lwt
, bisect_ppx
, qcheck-alcotest
}:

buildDunePackage rec {
  pname = "tezos-bls12-381-polynomial";
  version = "0.1.3";
  duneVersion = "3";
  src = fetchFromGitLab {
    owner = "nomadic-labs";
    repo = "privacy-team";
    rev = "v${version}";
    sha256 = "sha256-H1Wog3GItTIVsawr9JkyyKq+uGqbTQPTR1dacpmxLbs=";
  };

  propagatedBuildInputs = [ bls12-381 data-encoding mec ];

  checkInputs = [ alcotest alcotest-lwt bisect_ppx qcheck-alcotest ];

  doCheck = false; # circular dependencies

  meta = {
    description = "Polynomials over BLS12-381 finite field";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.ulrikstrid ];
  };
}

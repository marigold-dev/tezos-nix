{ lib
, fetchFromGitLab
, buildDunePackage
, bls12-381
, data-encoding
, alcotest
, alcotest-lwt
, bisect_ppx
}:

buildDunePackage rec {
  pname = "tezos-bls12-381-polynomial";
  version = "0.1.1";
  duneVersion = "3";
  src = fetchFromGitLab {
    owner = "nomadic-labs";
    repo = "privacy-team";
    rev = "v${version}";
    sha256 = "sha256-EGZZBB1ok8CDSu5Q3kKxFMtsuB1BrYabddTWAcs+Th8=";
  };

  propagatedBuildInputs = [ bls12-381 data-encoding ];

  checkInputs = [ alcotest alcotest-lwt bisect_ppx ];

  doCheck = true;

  meta = {
    description = "Polynomials over BLS12-381 finite field";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.ulrikstrid ];
  };
}

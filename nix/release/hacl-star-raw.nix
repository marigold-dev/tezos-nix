{
  lib,
  which,
  stdenv,
  fetchzip,
  opaline,
  cmake,
  ocaml,
  findlib,
  hacl-star,
  ctypes,
  cppo,
}:
stdenv.mkDerivation rec {
  pname = "ocaml${ocaml.version}-hacl-star-raw";
  version = "0.6.2";

  src = fetchzip {
    url = "https://github.com/project-everest/hacl-star/releases/download/ocaml-v${version}/hacl-star.${version}.tar.gz";
    sha256 = "sha256-yZNQyqmuhMl2qKdNV39fyf6TXlYIbIUL+k/3DoiKwe8=";
    stripRoot = false;
  };

  minimalOCamlVersion = "4.08";

  # strictoverflow is disabled because it breaks aarch64-darwin
  hardeningDisable = ["strictoverflow"];

  postPatch = ''
    patchShebangs ./
  '';

  buildPhase = ''
    make -C hacl-star-raw build-c
    make -C hacl-star-raw build-bindings
  '';

  preInstall = ''
  '';

  installPhase = ''
    echo $OCAMLFIND_DESTDIR
    mkdir $out
    mkdir -p $OCAMLFIND_DESTDIR/stublibs
    make -C hacl-star-raw install
  '';

  dontUseCmakeConfigure = true;
  dontAddPrefix = true;
  dontAddStaticConfigureFlags = true;
  configurePlatforms = [];
  createFindlibDestdir = true;

  nativeBuildInputs = [
    which
    cmake
    ocaml
    findlib
  ];

  propagatedBuildInputs = [
    ctypes
  ];

  checkInputs = [
    cppo
  ];

  strictDeps = true;

  doCheck = true;

  meta = {
    inherit (ocaml.meta) platforms;
    description = "Auto-generated low-level OCaml bindings for EverCrypt/HACL*";
    license = lib.licenses.asl20;
    maintainers = [lib.maintainers.ulrikstrid];
  };
}

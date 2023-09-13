{
  lib,
  src,
  version,
  buildDunePackage,
  libev,
  rustc,
  uri,
  fmt,
  qcheck-alcotest,
  lwt,
  pure-splitmix,
  data-encoding,
  ppx_expect,
  hex,
  zarith,
  zarith_stubs_js,
  aches,
  seqes,
  lwt-canceler,
  hacl-star,
  hacl-star-raw,
  ctypes_stubs_js,
  ctypes,
  ezjsonm,
  resto,
  resto-directory,
  bls12-381,
  re,
  secp256k1-internal,
  alcotest,
  bigarray-compat,
  eqaf,
  ppx_repr,
  bigstringaf,
  cmdliner,
  ppx_deriving,
  repr,
  stdint,
  logs,
  octez-distributed-lwt-internal,
  octez-alcotezt,
  aches-lwt,
  ipaddr,
  ptime,
  mtime_1,
  uutf,
  ringo,
  prometheus,
  irmin,
  irmin-pack,
  integers,
  integers_stubs_js,
  tezos-rust-libs,
  tezos-sapling-parameters,
  class_group_vdf,
  lwt-watcher,
  resto-cohttp,
  resto-cohttp-client,
  cohttp-lwt-unix,
  resto-cohttp-server,
  resto-acl,
  tezt,
  qcheck-core,
  bigstring,
}:
buildDunePackage rec {
  pname = "octez-libs";

  minimalOCamlVersion = "4.14.1";

  inherit src version;

  propagatedBuildInputs = [
    libev
    rustc

    uri
    fmt
    qcheck-alcotest
    lwt
    pure-splitmix
    data-encoding
    ppx_expect
    hex
    zarith
    zarith_stubs_js
    aches
    seqes
    lwt-canceler
    hacl-star
    hacl-star-raw
    ctypes_stubs_js
    ctypes
    ezjsonm
    resto
    resto-directory
    bls12-381
    re
    secp256k1-internal
    alcotest
    bigarray-compat
    eqaf
    ppx_repr
    bigstringaf
    cmdliner
    ppx_deriving
    repr
    stdint
    logs
    octez-distributed-lwt-internal
    octez-alcotezt
    aches-lwt
    ipaddr
    ptime
    mtime_1
    uutf
    ringo
    prometheus
    tezt
    irmin
    irmin-pack
    integers
    integers_stubs_js
    tezos-rust-libs
    tezos-sapling-parameters
    class_group_vdf
    lwt-watcher
    resto-cohttp
    resto-cohttp-client
    cohttp-lwt-unix
    resto-cohttp-server
    resto-acl
  ];

  checkInputs = [
    tezt
    qcheck-core
    bigstring
  ];

  doCheck = true;

  buildPhase = ''
    runHook preBuild
    dune build -p ${pname} ''${enableParallelBuilding:+-j $NIX_BUILD_CORES}
    runHook postBuild
  '';

  # This is a hack to work around the hack used in the dune files
  OPAM_SWITCH_PREFIX = "${tezos-rust-libs}";

  meta = {
    description = "A package that contains multiple base libraries used by the Octez suite";
    license = lib.licenses.mit;
    maintainers = [lib.maintainers.ulrikstrid];
  };
}

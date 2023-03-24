{
  nix2container,
  octez-node,
}:
nix2container.buildImage {
  name = "tezos-nix";
  config = {
    entrypoint = ["${octez-node}/bin/octez-node"];
  };
  layers = [
  ];
}

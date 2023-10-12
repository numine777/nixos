_: prev:

let
  allPkgs = prev.pkgs // pkgs;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  pkgs = {
    fb_idb = callPackage ../packages/fb-idb/1_1_8/package.nix { };
    idb_grpclib = callPackage ../packages/grpclib/0_4_1/package.nix { };
    treelib = callPackage ../packages/treelib/1_6_4/package.nix { };
  };
in
pkgs

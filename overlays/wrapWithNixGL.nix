# final: prev:

# with builtins;
# let
#   lib = prev.lib;

#   nixGL = import inputs.nixGL { pkgs = final; };
#   wrapWithNixGL = wrapper: package:
#     let
#       getBinFiles = pkg:
#         lib.pipe "${lib.getBin pkg}/bin" [
#           readDir
#           attrNames
#           (filter (n: match "^\\..*" n == null))
#         ];

#       wrapperBin = lib.pipe wrapper [
#         getBinFiles
#         (filter (n: n == (lib.getName wrapper)))
#         head
#         (x: "${wrapper}/bin/${x}")
#       ];

#       binFiles = getBinFiles package;
#       wrapBin = name:
#         final.writeShellScriptBin name ''
#           exec ${wrapperBin} ${package}/bin/${name} "$@"
#         '';
#     in
#     final.symlinkJoin {
#       name = "${package.name}-nixgl";
#       paths = (map wrapBin binFiles) ++ [ package ];
#     };
#   # lib = prev.lib;

#   # wrapWithNixGL = wrapper: package:
#   #   let
#   #     getBinFiles = pkg: lib.pipe "${lib.getBin pkg}/bin" [ readDir attrNames (filter (n: match "^\\..*" n == null)) ];

#   #     wrapperBin =
#   #       lib.pipe wrapper [ getBinFiles (filter (n: n == (lib.getName wrapper))) head (x: "${wrapper}/bin/${x}") ];

#   #     binFiles = getBinFiles package;
#   #     wrapBin = name:
#   #       final.writeShellScriptBin name ''
#   #         exec ${wrapperBin} ${package}/bin/${name} "$@"
#   #       '';
#   #   in
#   #   final.symlinkJoin {
#   #     name = "${package.name}-nixgl";
#   #     paths = (map wrapBin binFiles) ++ [ package ];
#   #   };
# in
# {
#   inherit wrapWithNixGL;
# }
final: prev:

with builtins;
let
  lib = prev.lib;

  nixGL = import inputs.nixGL { pkgs = final; };
  wrapWithNixGL = wrapper: package:
    let
      getBinFiles = pkg:
        lib.pipe "${lib.getBin pkg}/bin" [
          readDir
          attrNames
          (filter (n: match "^\\..*" n == null))
        ];

      wrapperBin = lib.pipe wrapper [
        getBinFiles
        (filter (n: n == (lib.getName wrapper)))
        head
        (x: "${wrapper}/bin/${x}")
      ];

      binFiles = getBinFiles package;
      wrapBin = name:
        final.writeShellScriptBin name ''
          exec ${wrapperBin} ${package}/bin/${name} "$@"
        '';
    in final.symlinkJoin {
      name = "${package.name}-nixgl";
      paths = (map wrapBin binFiles) ++ [ package ];
    };

  wrappers = let replacePrefix = replaceStrings [ "wrapWithNixGL" ] [ "nixGL" ];
  in lib.genAttrs [
    "wrapWithNixGLNvidia"
    "wrapWithNixGLIntel"
    "wrapWithNixGLDefault"
  ] (name: wrapWithNixGL final.${replacePrefix name});
in {
  inherit (nixGL) nixGLNvidia nixGLIntel nixGLDefault;
  inherit wrapWithNixGL;
} // wrappers

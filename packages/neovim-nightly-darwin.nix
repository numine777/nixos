{ neovim, liblpeg ? null, lib, ... }:

neovim.overrideAttrs (oa: {
  nativeBuildInputs = oa.nativeBuildInputs ++ lib.optionals (liblpeg != null) [
    liblpeg
  ];

  patches = builtins.filter
    (p:
      let
        patch =
          if builtins.typeOf p == "set"
          then baseNameOf p.name
          else baseNameOf p;
      in
      patch != "use-the-correct-replacement-args-for-gsub-directive.patch")
    oa.patches;
})

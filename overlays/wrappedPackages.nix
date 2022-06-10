{ ... }@inputs:
final: prev:

prev.lib.genAttrs [
  "kitty"
  "picom"
  "slack"
] (name: prev.wrapWithNixGLNvidia prev.${name})

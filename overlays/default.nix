{ inputs }:

[
  inputs.nix-minecraft.overlays.default
  (final: prev: {
    next = inputs.next.packages.${prev.stdenv.hostPlatform.system}.default;
    noctalia = inputs.noctalia.packages.${prev.stdenv.hostPlatform.system}.default;
    zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
  })
]

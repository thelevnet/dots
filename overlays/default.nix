{ inputs }:

[
  (import ../pkgs)
  inputs.nix-minecraft.overlays.default
  (_: prev: {
    next = inputs.next.packages.${prev.stdenv.hostPlatform.system}.default;
    noctalia = inputs.noctalia.packages.${prev.stdenv.hostPlatform.system}.default;
    rgit = inputs.rgit.packages.${prev.stdenv.hostPlatform.system}.default;
    rnet = inputs.rnet.packages.${prev.stdenv.hostPlatform.system}.default;
    zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
  })
]

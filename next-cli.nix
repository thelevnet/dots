{ lib, rustPlatform, installShellFiles }:

rustPlatform.buildRustPackage {
  pname = "next";
  version = "1.1.0";

  src = /home/lev/Projects/Rust/next;

  cargoLock.lockFile = /home/lev/Projects/Rust/next/Cargo.lock;

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd next \
      --zsh <($out/bin/next completions zsh) \
      --bash <($out/bin/next completions bash)
  '';

  meta = with lib; {
    description = "NixOS CLI wrapper";
    mainProgram = "next";
  };
}

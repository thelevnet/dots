{ lib, rustPlatform, installShellFiles, next-repo }:

rustPlatform.buildRustPackage {
  pname = "next";
  version = "1.1.0";

  src = next-repo;

  cargoLock.lockFile = "${next-repo}/Cargo.lock";

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

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }: let
    system = "x86_64-linux"; pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      # CLI Dev Tools (Nix only)
      nix-cli = pkgs.writeText "nix-cli.txt" ''
aria2 bun cargo dust fping ipinfo lf lolcat lsd micro nodejs nushell
oh-my-posh speed-cloudflare-cli speedtest-cli tgpt tree wush scrcpy
      '';
      # CLI Tools (Brew only) 
      brew-cli = pkgs.writeText "brew-cli.txt" ''
fastfetch fish gh git ripgrep tree fzf bat zoxide fd
      '';
      # DNF Critical (System only)
      dnf-critical = pkgs.writeText "dnf-critical.txt" ''
cockpit podman docker samba tailscale fish fuse
      '';
    };
  };
}

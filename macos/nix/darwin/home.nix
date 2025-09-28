{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "xprateek";
  home.homeDirectory = "/Users/xprateek";

  # Records HM data migration baseline; does not pin nixpkgs
  home.stateVersion = "24.05";

  # With home-manager.useGlobalPkgs = true, do not set nixpkgs.config/overlays here.

  programs.fish.enable = true;

  # Example: declare user dotfiles here if desired
  # home.file."config/fish/config.fish".text = ''
  #   # Managed fish config
  # '';
}

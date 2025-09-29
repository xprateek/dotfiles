{ config, lib, pkgs, ... }:

{
    imports = [
    # Include NixOS-WSL modules
    <nixos-wsl/modules>
    ];

    programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    };

    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable Fish Shell
    programs.fish.enable = true;
    users.users.nixos.shell = pkgs.fish;

    # Enable WSL
    wsl.enable = true;
    wsl.defaultUser = "nixos";

    # Enable Docker-desktop for WSl
    wsl.docker-desktop.enable = true;

    # Enable adb and related groups for Android development
    # programs.adb.enable = true;

    # Enable UnFree pkgs
    nixpkgs.config.allowUnfree = true;

    users.users.nixos.extraGroups = [
    "plugdev"  # Required for USB access (especially in native Linux, use if WSL supports USB access in the future)
    "adbusers" # Group for adb access, ensure it exists in the configuration
    ];

    environment.systemPackages = [
        #    pkgs.android-tools
        #    pkgs.android-udev-rules
        pkgs.apktool
        pkgs.cargo
        pkgs.conda
        pkgs.curl
        pkgs.dash
        pkgs.fastfetch
        pkgs.file
        pkgs.fish
        pkgs.gh
        pkgs.git
        pkgs.gnupg
        pkgs.htop
        pkgs.jq
        pkgs.lsd
        pkgs.libusb1
        pkgs.micro
        pkgs.openssh
        pkgs.oh-my-posh
        pkgs.p7zip
        pkgs.python312Full
        pkgs.python312Packages.conda
        pkgs.python312Packages.pip
        pkgs.pyenv
        pkgs.ripgrep-all
        pkgs.rustc
        pkgs.tree
        pkgs.usbutils
        pkgs.wget
        pkgs.wget2
        #    pkgs.zsh
        #    pkgs.zsh-autosuggestions
        #    pkgs.zulu
        pkgs.lolcat
        pkgs.wush
        pkgs.apfs-fuse
        pkgs.clang
        pkgs.tgpt
        pkgs.wush
    ];

    # Android-specific udev rules
    environment.etc."udev/rules.d/51-android.rules" = {
    text = ''
    # Android device rules
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="045e", MODE="0666"
    '';
};

system.stateVersion = "25.05";
# system.stateVersion = "unstable";
}

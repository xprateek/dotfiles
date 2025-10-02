{ config, lib, pkgs, ... }:

let
  # Import unstable channel
  unstable = import <nixos-unstable> {};
in

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hostname and networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable graphical environment (X11 + KDE Plasma)
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # For reliable graphics support, ensure OpenGL and AMD drivers are enabled:
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" "ati" ]; # For Radeon R5 M330

  # Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # Firmware
  hardware.enableAllFirmware = true;

  # Printing service with Gutenprint drivers and Avahi for network discovery
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.brlaser ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # Firewall settings: allow CUPS (631) and Avahi (5353) ports
  networking.firewall.allowedTCPPorts = [ 631 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Sound service (pipewire)
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Display Manager (SDDM)
  services.displayManager.sddm.enable = true;

  # User configuration
  users.users.prateek = {
    isNormalUser = true;
    description = "prateek";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "adbusers" "lp" ]; # Added 'lp' for printer management
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.fish;
  };

  # Enable fish shell globally
  programs.fish.enable = true;

  # Flatpak support
  services.flatpak.enable = true;

  # Android development tools
  programs.adb.enable = true;

  # Firefox browser
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix-ld for linked executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  # System packages
  environment.systemPackages = with pkgs; [
    android-studio android-tools android-udev-rules anydesk apktool aria2 black busybox clang cargo conda curl dash dart docker docker-compose fastfetch file fish fish-lsp flutter fontconfig gh git gnupg htop jq keepassxc kdePackages.kate lsd libreoffice-qt6-fresh libusb1 micro microsoft-edge nodejs_24 obs-studio openssh oh-my-posh p7zip podman postman postgresql python312Full python312Packages.conda python312Packages.django python312Packages.django-debug-toolbar python312Packages.fastapi python312Packages.pip ripgrep-all rustc tree toybox usbutils vlc vscode wget2 wireshark zsh zsh-autosuggestions zsh-history-to-fish zulu lolcat wush apfs-fuse yarn scrcpy gnumake cmake extra-cmake-modules tgpt readline zlib ncurses binutils pkg-config ollama openssl poppler_utils qpdf kde-rounded-corners brlaser
  ];

  # Auto upgrade system
  system.stateVersion = "25.05";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
}

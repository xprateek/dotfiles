{
  description = "Simplified nix-darwin config for BEEM41 macOS aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
  };

  outputs = { self, nixpkgs, nix-darwin, ... }:
  let
    system = "aarch64-darwin";
    hostname = "BEEM41";
    username = "pmaru";

    pkgs = nixpkgs.legacyPackages.${system};

    # Packages managed by nix profile only (not Homebrew) - install with: nix profile install nixpkgs#<pkg>
    profilePackages = with pkgs; [
      aria2
      bun
      cargo
      dust
      fping
      ipinfo
      lf
      lolcat
      lsd
      micro
      nodejs
      nushell
      oh-my-posh
      speed-cloudflare-cli
      speedtest-cli
      tgpt
      tree
      wush
      scrcpy
    ];

    # Packages managed by Homebrew via nix-darwin
    homebrewPackages = [
      "brotli"
      "ca-certificates"
      "coreutils"
      "curl"
      "docker"
      "docker-compose"
      "fastfetch"
      "fish"
      "gettext"
      "gh"
      "git"
      "gmp"
      "krb5"
      "libevent"
      "libidn2"
      "libnghttp2"
      "libnghttp3"
      "libngtcp2"
      "libssh2"
      "libtasn1"
      "libunistring"
      "libxcrypt"
      "libyaml"
      "lmdb"
      "lz4"
      "mas"
      "podman"
      "podman-compose"
      "popt"
      "python3"
      "readline"
      "ripgrep"
      "rtmpdump"
      "samba"
      "sqlite"
      "supabase"
      "talloc"
      "tdb"
      "tevent"
      "unbound"
      "xz"
      "yyjson"
      "zstd"
    ];

    configuration = {
      system.primaryUser = username;

      users.users.${username} = {
        name = username;
        home = "/Users/${username}";
        shell = pkgs.fish;
      };

      programs.fish.enable = true;

      # systemPackages silently fails for aarch64-darwin non-Hydra pkgs
      # All profilePackages already installed via nix profile install
      environment.systemPackages = [ ];

      nix.enable = false; # Disable nix management by nix-darwin for Determinate Nix

      homebrew = {
        enable = true;
        taps = [];

        brews = homebrewPackages;

        casks = [
          "anaconda"
          "android-platform-tools"
          "docker-desktop"
          "font-caskaydia-mono-nerd-font"
          "font-fira-code-nerd-font"
          "google-chrome"
          "libreoffice"
          "libreoffice-language-pack"
          "podman-desktop"
          "proton-drive"
          "proton-mail"
          "proton-pass"
          "protonvpn"
          "visual-studio-code"
          "vivaldi@snapshot"
          "wezterm"
        ];

        masApps = {
          "Perplexity" = 6714467650;
          "Proton Pass for Safari" = 6502835663;
          "Tailscale" = 1475387142;
          "Telegram" = 747648890;
          "WhatsApp" = 310633997;
        };

        onActivation = {
          autoUpdate = false;
          upgrade = false;
          cleanup = "zap";
        };
      };

      # Simplified: no Nix apps have /Applications contents
      system.activationScripts.applications.text = ''
        echo "setting up /Applications/Nix Apps..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        echo "No Nix apps to link (all in ~/.nix-profile)" >&2
      '';

      nix.settings.experimental-features = "nix-command flakes";

      system.stateVersion = "24.11";  # Fixed: was invalid integer 6

      nixpkgs.config.allowUnfree = true;
    };

  in {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      system = system;
      pkgs = pkgs;
      modules = [ configuration ];
    };

    # Atomic profile installer
    packages.${system}.installProfilePackages = pkgs.writeShellApplication {
      name = "install-profile-packages";
      runtimeInputs = [ pkgs.fish ];
      text = ''
        set pkgs ${toString profilePackages}
        for pkg in $pkgs
          echo "Installing nixpkgs#$pkg..."
          nix profile install nixpkgs#$pkg
        end
        echo "✅ All profile packages installed!"
      '';
    };
  };
}

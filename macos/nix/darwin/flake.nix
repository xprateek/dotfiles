{
  description = "nix-darwin + Home Manager (rolling) with Homebrew";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixpkgs-unstable, ... }:
  let
    hostname = "Prateeks-Mac-mini";
    username = "xprateek";

    addUnstable = final: _prev: {
      unstable = import nixpkgs-unstable {
        system = "aarch64-darwin";
        config = final.config or {};
        overlays = final.overlays or [];
      };
    };

    configuration = { pkgs, lib, config, ... }: {
      nixpkgs = {
        config.allowUnfree = true;
        overlays = [ addUnstable ];
      };

      system.primaryUser = username;

      users.users.${username} = {
        name = username;
        home = "/Users/${username}";
        shell = pkgs.fish;
      };

      programs.fish.enable = true;

      environment.systemPackages = with pkgs; [
        bun
        awscli2
        micro
        openssl 
        zoxide
        go
        tmux
        neovim
        ffmpeg
        jq
        ripgrep
        git
        curl
        coreutils
      ];

      homebrew = {
        enable = true;

        taps = [
          { name = "domt4/autoupdate"; }
          { name = "lonebrew/apps"; }
          { name = "mhaeuser/mhaeuser"; }
          { name = "mistertea/et"; }
          { name = "natesales/repo"; clone_target = "https://github.com/natesales/repo"; }
          { name = "nrlquaker/createzap"; }
        ];

        brews = [
          "brotli"
          "xz"
          "zstd"
          "openssl@3"
          "aria2"
          "bash"
          "binutils"
          "borgbackup"
          "pcre2"
          "glib"
          "checkbashisms"
          "dateutils"
          "diceware"
          "erofs-utils"
          "eza"
          "gnutls"
          "harfbuzz"
          "libsodium"
          "findutils"
          "flock"
          "fping"
          "gawk"
          "gcc"
          "gdrive"
          "node"
          "gemini-cli"
          "gh"
          "gnu-sed"
          "gnu-tar"
          "gnu-time"
          "grep"
          "grepcidr"
          "pkgconf"
          "guile"
          "gyb"
          "id3lib"
          "imagemagick"
          "ipcalc"
          "iperf3"
          "mas"
          "moreutils"
          "mosh"
          "mp3wrap"
          "mtr"
          "nano"
          "nmap"
          "ntp"
          "openssh"
          "p7zip"
          "pass"
          "pigz"
          "pinentry-mac"
          "pre-commit"
          "pssh"
          "pwgen"
          "rclone"
          "rsync"
          "scrcpy"
          "shellcheck"
          "shfmt"
          "speedtest-cli"
          "ssh3"
          "sshuttle"
          "swaks"
          "telnet"
          "trippy"
          "trufflehog"
          "wget"
          "whois"
          "wush"
          "xcodes"
          "yt-dlp"
          "lonebrew/apps/ripasso-cursive"
          "mistertea/et/et"
          "natesales/repo/q"
        ];

        casks = [
          "aldente"
          "android-platform-tools"
          "anydesk"
          "appcleaner"
          "box-drive"
          "brave-browser"
          "chrome-remote-desktop-host"
          "element"
          "finicky"
          "font-caskaydia-cove-nerd-font"
          "gimp"
          "google-chrome"
          "google-drive"
          "iina"
          "macpass"
          "menumeters"
          "protonvpn"
          "resilio-sync"
          "safari-technology-preview"
          "signal"
          "stremio"
          "universal-android-debloater"
          "utm"
          "whatsapp"
          "youtube-music"
          "alacritty"
          "anaconda"
        ];

        masApps = {
          "Perplexity" = 6714467650;
        };

        onActivation = {
          autoUpdate = false;
          upgrade = false;
          cleanup = "zap";
        };
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in lib.mkForce ''
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + | \
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

      nix.settings.experimental-features = "nix-command flakes";

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;

      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = import ./home.nix;
        }
      ];
    };

    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}

{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "xprateek";
  home.homeDirectory = "/Users/xprateek";

  home.stateVersion = "24.05";

  programs.fish.enable = true;

  home.file."config/fish/config.fish".text = ''
    # Oh My Posh prompt init with Tokyo Night Storm theme
    oh-my-posh init fish --config ~/.config/oh-my-posh/tokyonight_storm.omp.json | source

    # PATH setup (NO coreutils/findutils gnubin)
    fish_add_path /opt/homebrew/sbin
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/opt/binutils/bin
    fish_add_path /opt/homebrew/opt/whois/bin
    fish_add_path /opt/homebrew/opt/curl/bin
    fish_add_path $HOME/.nix-profile/bin
    fish_add_path /run/current-system/sw/bin
    fish_add_path /nix/var/nix/profiles/default/bin
    fish_add_path /Users/xprateek/.pixi/bin
    fish_add_path /Users/xprateek/.bin
    fish_add_path /usr/local/bin
    fish_add_path /usr/bin
    fish_add_path /bin
    fish_add_path /usr/sbin
    fish_add_path /sbin

    # Aliases
    alias yum='brew'
    alias apt='brew'
    alias dnf='brew'
    alias ls='eza'
    alias ll='ls -alF --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -CF --color=auto'
    alias gs='git status'
    alias gd='git diff'
    alias gc='git commit'
    alias gp='git push'
    alias gl='git log --oneline --graph --all --decorate'
    alias hcc='history clear'

    # Colorize man pages
    set -gx MANPAGER "col -bx | bat -l man -p"

    # Default editor
    set -gx EDITOR micro
    set -gx VISUAL micro

    # Autosuggestions with custom color
    set -g fish_autosuggestion_enabled 1
    set -g fish_color_autosuggestion "555555"

    # Reload function
    function reload
      source ~/.config/fish/config.fish
      echo "Fish config reloaded!"
    end

    # Archive extraction helper
    function extract
      if test (count $argv) -eq 0
        echo "Usage: extract <file>"
        return 1
      end
      set file $argv[1]
      switch $file
        case '*.tar.bz2' '*.tbz2'
          tar xjf $file
        case '*.tar.gz' '*.tgz'
          tar xzf $file
        case '*.tar.xz'
          tar xf $file
        case '*.zip'
          unzip $file
        case '*'
          echo "Cannot extract $file"
          return 1
      end
    end

    # Toggle git branch in prompt
    function toggle-git-branch
      set -q __fish_git_prompt_show_branch
      if test $__fish_git_prompt_show_branch = 1
        set -e __fish_git_prompt_show_branch
        echo "Git branch prompt OFF"
      else
        set -gx __fish_git_prompt_show_branch 1
        echo "Git branch prompt ON"
      end
      reload
    end
  '';
}

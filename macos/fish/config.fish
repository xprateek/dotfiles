# Oh My Posh prompt
oh-my-posh init fish --config '/Users/pmaru/.bin/files/hul10.omp.json' | source

function fish_greeting; prateek | lolcat ; end

# Essential PATHs
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path $HOME/.nix-profile/bin
fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path /Users/pmaru/.bin
fish_add_path $HOME/.bun/bin
fish_add_path /opt/homebrew/anaconda3/bin

# Aliases
alias ping='fping'
alias rp='realpath'
alias cls='clear'
alias ai='tgpt'
alias cal='nu -c cal'
alias nls='nu -c ls'
alias ls='lsd -a'
alias l1='lsd -a1'
alias ll='lsd -alF'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias ef='exec fish'
alias mfish='micro /Users/pmaru/.config/fish/config.fish'
alias mflake='micro /Users/pmaru/.config/nixpkgs/flake.nix'
alias muppdate='micro /Users/pmaru/.bin/uppdate'
alias hcc='history clear'
alias allpkgs='nix-list && brew list'
alias imgcat='wezterm imgcat'
alias del='rm -rf'

# Editor
set -gx EDITOR micro
set -gx VISUAL micro

# Custom Exports 
set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM 1

# Quick Fn

# List installed profiles
function nplist
    nix profile list
end

# Add package to profile (like nix install)
function npadd
    if test (count $argv) -eq 0
        echo "Usage: nix-install <package>"
        return 1
    end
    nix profile add nixpkgs#$argv[1]
end

# Remove package from profile
function nprm
    if test (count $argv) -eq 0
        echo "Usage: nix-remove <package>"
        return 1
    end
    nix profile remove $argv[1]
end

# Show info about a package
function npinfo
    if test (count $argv) -eq 0
        echo "Usage: nix-info <package>"
        return 1
    end
    nix search nixpkgs $argv[1]
end



# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by Antigravity
fish_add_path /Users/pmaru/.antigravity/antigravity/bin

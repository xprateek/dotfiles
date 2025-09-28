if status is-interactive
    # Commands to run in interactive sessions can go here
end

# SET BASH PATH HERE

set -gx PATH /home/pmaru/.local/bin /home/pmaru/bin /home/pmaru/.bin /home/pmaru/.nix-profile/bin /nix/var/nix/profiles/default/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# Oh My Posh prompt
oh-my-posh init fish --config $HOME/.bin/hul10.omp.json | source

function fish_greeting
    # prateek | lolcat
end

# Essential PATHs
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path $HOME/.nix-profile/bin
fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path $HOME/.bin
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.anaconda3/bin

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
alias mfish='micro $HOME/.config/fish/config.fish'
alias mflake='micro $HOME/.config/nixpkgs/flake.nix'
alias muppdate='micro $HOME/.bin/uppdate'
alias hcc='history clear'
alias allpkgs='nix profile list && brew list'
alias imgcat='wezterm imgcat'
alias del='rm -rf'

# Editor
set -gx EDITOR micro
set -gx VISUAL micro

# Custom Exports
set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM 1

# Quick Functions

# List installed profiles
function nplist
    nix profile list
end

# Add package to profile (like nix install)
function npadd
    if test (count $argv) -eq 0
        echo "Usage: npadd <package>"
        return 1
    end
    nix profile add "nixpkgs#$argv[1]"
end

# Remove package from profile
function nprm
    if test (count $argv) -eq 0
        echo "Usage: nprm <package>"
        return 1
    end
    nix profile remove $argv[1]
end

# Show info about a package
function npinfo
    if test (count $argv) -eq 0
        echo "Usage: npinfo <package>"
        return 1
    end
    nix search nixpkgs $argv[1]
end

# bun environment variables
set -gx BUN_INSTALL $HOME/.bun
fish_add_path $BUN_INSTALL/bin

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

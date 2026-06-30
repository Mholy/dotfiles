set -gx EDITOR hx

if status is-interactive
    fzf --fish | source
    zoxide init fish --cmd j | source
    keychain --eval --quiet --confallhosts | source
    alias ls='eza --group-directories-first'
    alias ll='eza -lh --group-directories-first'
    alias la='eza -lah --group-directories-first'
    alias cat='bat'
    alias lg='lazygit'
end

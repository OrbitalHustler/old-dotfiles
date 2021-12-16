FZF_LINK="$HOME/.local/fzf"
# Setup fzf
# ---------
path=("$FZF_LINK/bin" $path)

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_LINK/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_LINK/shell/key-bindings.zsh"

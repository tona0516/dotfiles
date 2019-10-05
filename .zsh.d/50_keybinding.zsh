# emacsキーバインド
bindkey -e

if zplug check "junegunn/fzf-bin"; then
    zle -N select-snippets
    bindkey '^s' select-snippets
fi

if zplug check "mollifier/anyframe"; then
    zstyle ":anyframe:selector:" use fzf
    zstyle ":anyframe:selector:fzf:" command 'fzf --no-sort'
    bindkey '^r' anyframe-widget-put-history
    bindkey '^f' anyframe-widget-insert-filename
fi


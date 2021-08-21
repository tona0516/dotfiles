# install zplug
if [ ! -e ~/.zplug ]; then
    export ZPLUG_HOME=~/.zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source ~/.zplug/init.zsh
ZPLUG_PROTOCOL=HTTPS

# install plugins
if is_mac; then
    zplug "junegunn/fzf", as:command, from:gh-r, rename-to:fzf, use:"*darwin*amd64*"
else
    zplug "junegunn/fzf", as:command, from:gh-r, rename-to:fzf
fi
# note: to avoid "__enhancd::sources::default:6: bad pattern:~"
zplug "b4b4r07/enhancd", use:init.sh, at:f0f894029d12eecdc36c212fa3ad14f55468d1b7
if zplug check "b4b4r07/enhancd"; then
    ENHANCD_DISABLE_HOME=0
    ENHANCD_DISABLE_DOT=1
    ENHANCD_DISABLE_HYPHEN=1
    ENHANCD_FILTER=fzf
fi
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", lazy:true
zplug "zsh-users/zsh-autosuggestions", use:zsh-autosuggestions.zsh, defer:2
if zplug check "zsh-users/zsh-autosuggestions"; then
    ZSH_AUTOSUGGEST_USE_ASYNC=true
fi
zplug "mollifier/anyframe"
zplug "chrissicool/zsh-256color"

INT_ZSH_VERSION=$(echo $ZSH_VERSION | awk -F. '{printf "%2d%02d%02d", $1,$2,$3}')
if [ "$INT_ZSH_VERSION" -ge 50300 ]; then
    zplug "romkatv/gitstatus", use:'gitstatus.prompt.zsh'
    # zplug "romkatv/powerlevel10k", as:theme, depth:1, hook-load:"source ~/.p10k.zsh"
else
    zplug "themes/ys", from:oh-my-zsh
fi
zplug "mollifier/cd-gitroot"
zplug 'wfxr/forgit'

# install and load
if ! zplug check --verbose; then
    zplug install
fi
zplug load

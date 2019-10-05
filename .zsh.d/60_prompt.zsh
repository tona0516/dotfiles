if ! zplug check "romkatv/gitstatus"; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' formats '%b'
    zstyle ':vcs_info:*' actionformats '%b|%a'
    function precmd() {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
    RPROMPT=""
    PROMPT="%F{214}%M%f %F{white}at%f %F{cyan}%~%f %1(v|%F{white}on%f %F{196}%1v%f|)
    %B%F{yellow}> %f%b%{${reset_color}%}"
fi

# CORES BÁSICAS
ativar_cores() {
    if tput setaf 1 &>/dev/null; then
        bold=$(tput bold)
        white=$(tput setaf 7)
        red=$(tput setaf 1)
        green=$(tput setaf 2)
        cyan=$(tput setaf 6)
        yellow=$(tput setaf 3)
        blue=$(tput setaf 38)
        reset=$(tput sgr0)
    else
        bold="\033[4;37m"
        white="\033[0;37m"
        red="\033[0;31m"
        green="\033[0;32m"
        cyan="\033[0;36m"
        yellow="\033[0;33m"
        blue="\033[0;34m"
        reset="\033[0m"
    fi
}
ativar_cores

cor() {
    local codes=()
    if [ "$1" = 'bold' ]; then
        codes=("${codes[@]}" '1')
        shift
    fi
    if [ "$#" -gt 0 ]; then
        local code=
        case "$1" in
        # see https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
        black) code=30 ;;
        red) code=31 ;;
        green) code=32 ;;
        yellow) code=33 ;;
        blue) code=34 ;;
        magenta) code=35 ;;
        cyan) code=36 ;;
        white) code=37 ;;
        esac
        if [ "$code" ]; then
            codes=("${codes[@]}" "$code")
        fi
    fi
    local IFS=';'
    echo -en '\033['"${codes[*]}"'m'
}

msg_cor() {
    text="$1"
    shift
    cor "$@"
    echo -n "$text"
    cor reset
    echo
}

sucesso() {
    echo "$(msg_cor "$2" green) $(msg_cor "$1" white)"
}
erro() {
    echo "$(msg_cor "$2" red) $(msg_cor "$1" white)"
}
aviso() {
    echo -n "$(msg_cor "─► " yellow)"
    msg_cor >&2 "$*" cyan
}
nota() {
    echo "$(msg_cor "$2" yellow) $(msg_cor "$1" white)"
}

info_log() {
    echo "$(msg_cor "====" blue) $(msg_cor "$*" cyan) $(msg_cor "====" blue)"
}
msg_sucesso() {
    # Mensagem de sucesso
    if [[ $# -gt 0 ]] && [[ $1 == -l ]]; then
        [ "${2-}" != "" ] && printf "[ \033[0;32m✔️ \033[0m]\n  └──\033[0;32m►\033[0m %s\n" "${2-}"
    else
        [ "${1-}" != "" ] && printf "[ \033[0;32m✔️ \033[0m]\033[0;32m►\033[0m %s\n" "${1-}"
    fi
}
msg_erro() {
    # Mensagem de erro
    if [[ $# -gt 0 ]] && [[ $1 == -l ]]; then
        [ "${2-}" != "" ] && printf "[ \033[0;31m❌\033[0m]\n  └──\033[0;31m►\033[0m %s\n" "${2-}"
    else
        [ "${1-}" != "" ] && printf "[ \033[0;31m❌\033[0m]\033[0;31m►\033[0m %s\n" "${1-}"
    fi
}
msg_info() {
    # Mensagem de informação
    if [[ $# -gt 0 ]] && [[ $1 == -l ]]; then
        [ "${2-}" != "" ] && printf "[ \033[0;34mⓘ \033[0m]\n  └──\033[0;34m►\033[0m %s\n" "${2-}"
    else
        [ "${1-}" != "" ] && printf "[ \033[0;34mⓘ \033[0m]\033[0;34m►\033[0m %s\n" "${1-}"
    fi
}
msg_atencao() {
    # Mensagem de atenção
    if [[ $# -gt 0 ]] && [[ $1 == -l ]]; then
        [ "${2-}" != "" ] && printf "[ \033[0;33m⚠ \033[0m]\n  └──\033[0;33m►\033[0m %s\n" "${2-}"
    else
        [ "${1-}" != "" ] && printf "[ \033[0;33m⚠ \033[0m]\033[0;33m►\033[0m %s\n" "${1-}"
    fi
}
msg_nota() {
    # Mensagem de nota
    if [[ $# -gt 0 ]] && [[ $1 == -l ]]; then
        [ "${2-}" != "" ] && printf "[ \033[0;33mNOTA: \033[0m]\n    └──\033[0;33m►\033[0m %s\n" "${2-}"
    else
        [ "${1-}" != "" ] && printf "\r\033[0;33mNOTA:\033[0m %s\n" "${1-}"
    fi
}
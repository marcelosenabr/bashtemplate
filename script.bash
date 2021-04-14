logo() {
    printf "${blue}%s%s${reset}\n" "         \\\\\/" "//         "
    printf "%s\n" "        / _  _ \        "
    printf "%s\n" "      (| (.)(.) |)      "
    printf "${cyan}%s${reset}%s${cyan}%s${reset}%s${cyan}%s${reset}%s${reset}" "    _" "OOOo" "__" "()" "_ " "oOOO" "______ ___"
    printf "${cyan}%s\n" "     "
    printf "%s\n" "   /  _/ _ \ | /| / /_  // _ ) "
    printf "%s\n" "  _/ / \_, / |/ |/ //_ </ _  | "
    printf "${cyan}%s${reset}%s${cyan}%s${reset}\n" " /__" "oooO" "__/|__/|__/____/____/  "
    printf "%s\n" "     (   )   Oooo   "
    printf "%s\n" "      \ (    (   )  "
    printf "%s\n" "       \_)    ) /   "
    printf "%s\n" "             (_/    "
}

executar_uso() {
    # Opções e Uso
    echo && logo
    echo -e "\nUso: $(basename "${BASH_SOURCE[0]}") opcoes
Opções:
  -h, --help          Exibir esta ajuda e sair
  -d, --dependencies  Verificar dependências do script
  -v, --version       Exibir informações da versão e saír
"
    exit 0
}

executar_version() {
    if [[ -z $(dirname "${BASH_SOURCE[0]}") ]]; then
        # script chamado sem path
        # shellcheck disable=SC2230
        script_install_path=$(which "${BASH_SOURCE[0]}")
        if [[ -n $(readlink "$script_install_path") ]]; then
            # quando o script foi instalado com, por exemplo basher
            script_install_path=$(readlink "$script_install_path")
        fi
        script_install_folder=$(dirname "$script_install_path")
    else
        # script com caminho relativo/absoluto
        script_install_folder=$(dirname "${BASH_SOURCE[0]}")
        # resolve para o caminho absoluto
        script_install_folder=$(cd "$script_install_folder" && pwd)
        if [[ -n "$script_install_folder" ]]; then
            script_install_path="$script_install_folder/$script_basename"
        else
            script_install_path="${BASH_SOURCE[0]}"
            script_install_folder=$(dirname "${BASH_SOURCE[0]}")
        fi
        if [[ -n $(readlink "$script_install_path") ]]; then
            script_install_path=$(readlink "$script_install_path")
            script_install_folder=$(dirname "$script_install_path")
        fi
    fi

    # obter a versão do script em VERSION.md -que é atualizado automaticamente
    [[ -f "$script_install_folder/VERSION.md" ]] && script_version=$(cat "$script_install_folder/VERSION.md")
    echo -e "${green}►${reset} Programa: ${green}$script_basename ${reset}v${green}$script_version${reset} por ${yellow}$script_author${reset}"
    exit 0
}
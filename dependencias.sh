#!/bin/bash

dependencias=$(cat dependencias)

installed() {
    return $(dpkg-query -W -f '${Status}\n' "${1}" 2>&1 | awk '/ok installed/{print 0;exit}{print 1}')
}

check_dependencias() {
    depende="$@"
    instalar_pacotes=""
    instalado=""
    for pkg in ${depende[@]}; do
        if ! $(installed $pkg); then
            instalar_pacotes+=" $pkg"
        else
            instalado+=" $pkg"
        fi
    done

    if [ ! -z "$instalado" ]; then
        info_log "Pacotes Instalados $(msg_cor "[ " white)$(msg_cor "✓" green)$(msg_cor " ]" white)"
        for inst in ${instalado[@]}; do
            sucesso "${inst}" 'ok ✓'
        done
    fi

    if [ ! -z "$instalar_pacotes" ]; then
        echo
        info_log "Pacotes Pendente $(msg_cor "[ " white)$(msg_cor "✖" red)$(msg_cor " ]" white)"
        for inst_pac in ${instalar_pacotes[@]}; do
            erro "${inst_pac}" '✖'
        done
    fi

    echo
    if [ ! -z "$instalar_pacotes" ]; then
        info_log "Instalar Dependências"
        for instPac in ${instalar_pacotes[@]}; do
            echo
            aviso "$(msg_cor "Instalando" white) $(msg_cor "$instPac" cyan)"
            echo
            sudo apt-get install -qy $instPac
        done
        instalar_pacotes=""
        instalado=""
        for pkg in ${depende[@]}; do
            if ! $(installed $pkg); then
                instalar_pacotes+=" $pkg"
            else
                instalado+=" $pkg"
            fi
        done
        clear
        if [ ! -z "$instalado" ]; then
            info_log "Pacotes Instalados $(msg_cor "[ " white)$(msg_cor "✓" green)$(msg_cor " ]" white)"
            for inst in ${instalado[@]}; do
                sucesso "${inst}" 'ok ✓'
            done
        fi
        if [ ! -z "$instalar_pacotes" ]; then
            echo
            erro "Erro Na Instalação dos Pacotes" '✖'
            echo
        else
            echo
            nota "Todos os Pacotes Instalando $(msg_cor "[ " white)$(msg_cor "✓" green)$(msg_cor " ]" white)" "─►"
            echo
        fi
    else
        nota "Todos os Pacotes Instalando $(msg_cor "[ " white)$(msg_cor "✓" green)$(msg_cor " ]" white)" "─►"
        echo
    fi
}
check_dependencias "${dependencias[@]}"
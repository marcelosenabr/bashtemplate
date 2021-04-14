#!/usr/bin/env bash
# ===========================================================================
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && cd .. && pwd -P)
# ===========================================================================
. $script_dir/env.bash
. $script_dir/cores.bash
. $script_dir/script.bash
# ===========================================================================
main() {
	while test $# -gt 0; do
		case "$1" in
		"-h" | "--help")
			executar_uso
			;;
		"-v" | "--version")
			executar_version
			;;
		"-d" | "--dependencies")
			. dependencias.sh
			;;
		*)
			echo
			erro "Opção inválida: $1\n"
			executar_uso
			;;
		esac
		shift
	done
	[[ $# -eq 0 ]] && echo >/dev/null 2>&1
}
main "$@"
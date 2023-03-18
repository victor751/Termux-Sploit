#!bin/bash

COR1="$(printf '\033[1;31m')"
COR5="$(printf '\033[1;33m')"
COR0="$(printf '\033[1;37m')"
COR2="$(printf '\033[1;32m')"

clear;

exit_on_signal_SIGINT() {
        { printf "\n\n%s\n\n" "${COR1}[×] VOCÊ APERTOU CTRL+C. O PROGRAMA FOI INTERROMPIDO!" 2>&1; }
        exit 0
}

exit_on_signal_SIGTERM() {
        { printf "\n\n%s\n\n" " Program Terminated." 2>&1; }
        exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM


banner() {
	cat <<- EOF
		${COR1}
		${COR1}     ___   ________  _____    ____  ____  ______
		${COR1}    /   | / ____/ / / /   |  / __ \/ __ \/ ____/
		${COR1}   / /| |/ / __/ / / / /| | / /_/ / / / / __/
		${COR1}  / ___ / /_/ / /_/ / ___ |/ _, _/ /_/ / /___ _ _ _
		${COR1} /_/  |_\____/\____/_/  |_/_/ |_/_____/_____/(_|_|_)
		${COR1}
		${COR1}
	EOF
}

dependencias() {
	{ sleep 1; }
	echo "${COR5}[ ~ ] AGUARDE! INSTALANDO DEPENDÊNCIAS... ${COR0}"
	echo ""
	{ sleep 2; }
	pkg install aapt
	pkg install aapt2
	pkg install apksigner
	pkg install ruby
	pkg install openjdk-17
	{ sleep 1; clear; }
}

banner2() {
	cat <<- EOF
		${COR2}
		${COR2}   __________  _   __________    __  __________  ____     __
		${COR2}  / ____/ __ \/ | / / ____/ /   / / / /  _/ __ \/ __ \   / /
		${COR2} / /   / / / /  |/ / /   / /   / / / // // / / / / / /  / /
		${COR2}/ /___/ /_/ / /|  / /___/ /___/ /_/ // // /_/ / /_/ /  /_/
		${COR2}\____/\____/_/ |_/\____/_____/\____/___/_____/\____/  (_)
		${COR2}
	EOF
}

mini() {
	{ sleep 2; }
	echo ""
	echo ""
	echo "${COR1} [ ${COR5}+ ${COR1}]${COR0} PARA CONTINUAR USE '${COR2} bash sploit.sh ${COR0}'..."
	echo ""
	echo ""
	echo ""
}

banner
dependencias
banner2
mini

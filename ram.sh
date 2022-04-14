#!user/bin/env bash

#Author: Alessandro Braun ablenda@gmail.com
#Discribe: Ferramenta para limpeza de chache de memória ram.
#Version: 0.2
#License: GPL

  echo "------ESVAZIAR CACHE DE MEMÓRIA------"

    sudo sync && sudo sysctl -w vm.drop_caches=3
    sudo sync; sudo echo 3 > /proc/sys/vm/drop_caches
    sudo sync; sudo echo 2 > /proc/sys/vm/drop_caches
    sudo sync; sudo echo 1 > /proc/sys/vm/drop_caches

  echo "------FIM DO PROCESSO------"

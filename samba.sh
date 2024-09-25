#!/usr/bin/env sh

# Configurações do servidor Samba
samba_server="fileserver.local"
samba_share="//fileserver.local/data/backup"
samba_mount="/mnt/backup"
username="user"  # Substitua pelo seu nome de usuário do Samba
password="password"   # Substitua pela sua senha do Samba

# Montando o compartilhamento Samba
if ! mount -t cifs "$samba_share" "$samba_mount" -o username="$username",password="$password"; then
    printf "Falha ao montar o compartilhamento Samba %s. VERIFIQUE.\n" "$samba_share" | tee -a "$log_file"
    exit 1
fi

# Verificando se o diretório de montagem está acessível
if ! ls "$samba_mount" > /dev/null 2>&1; then
    printf "Falha ao acessar o compartilhamento Samba montado em %s. VERIFIQUE.\n" "$samba_mount" | tee -a "$log_file"
    umount "$samba_mount"
    exit 1
fi


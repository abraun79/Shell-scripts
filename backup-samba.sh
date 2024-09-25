#!/usr/bin/env sh

# Diretório de backup
backup_path="/home/user"

# Configurações do servidor Samba
samba_server="fileserver.local"
samba_share="//fileserver.local/data/backup"
samba_mount="/mnt/backup"
username="user"  # Substitua pelo seu nome de usuário do Samba
password="password"   # Substitua pela sua senha do Samba

# Formato do arquivo de backup
date_format=$(date "+%d-%m-%Y_%H-%M")
final_archive="backup-$date_format.tar.gz"

# Local do arquivo de log
log_file="/var/log/daily-backup.log"

#######################
#       TESTE         #
#######################

# Criando o diretório de montagem, se não existir
if [ ! -d "$samba_mount" ]; then
    mkdir -p "$samba_mount"
fi

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

# Checando se o log é gravável
if [ ! -w "$log_file" ]; then
    printf "O arquivo de log %s não é gravável. VERIFIQUE.\n" "$log_file"
    exit 1
fi

#######################
#   Início de backup  #
#######################

printf "Iniciando backup: %s\n" "$(date)" | tee -a "$log_file"

# Executando o backup, excluindo arquivos ocultos
if tar --exclude='.*' -czSpf "$samba_mount/$final_archive" \
    -C "$backup_path" Documentos Downloads Imagens Vídeos Músicas Projeto Shell-scripts; then
    printf "Backup concluído com sucesso: %s/%s\n" "$samba_mount" "$final_archive" | tee -a "$log_file"
else
    printf "Falha no backup: %s\n" "$(date)" | tee -a "$log_file"
    umount "$samba_mount"
    exit 1
fi

printf "Backup finalizado: %s\n" "$(date)" | tee -a "$log_file"

# Desmontando o compartilhamento Samba
umount "$samba_mount"

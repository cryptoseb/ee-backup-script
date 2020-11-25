#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
EE_PATH="/opt/easyengine/sites"
BACKUP_DIR_C="/root/ee-backups-ss/"
BACKUP_PATH="/root"
DATE=`date +%Y-%m-%d`
CHOWN="root:root"

RED='\033[0;31m'
YELLOW='\033[1;33m'
LIGHT_GREEN='\033[1;32m'
LIGHT_GRAY='\033[0;37m'
NC='\033[0m'

for SITES in $(ls $EE_PATH)
do
echo " "
echo " "
echo "${YELLOW}================= ${NC}[ ${LIGHT_GREEN}Starting ${NC}EasyEngine Backup Script by @CryptoSeb ] ${YELLOW}=================${NC}"
echo " "
echo "Making backup folder in ${LIGHT_GRAY}${BACKUP_PATH}${NC}"
mkdir -p ${BACKUP_DIR_C}${DATE}
echo " "
echo "Backing up WordPress database to ${LIGHT_GRAY}webroot${NC}"
ee shell ${SITES} --command="wp db export ${SITES}.sql"
echo " "
echo "Copying ${LIGHT_GRAY}${SITES} ${NC}to ${LIGHT_GRAY}${BACKUP_DIR_C}${NC}"
cp -r ${EE_PATH} ${BACKUP_DIR_C}${DATE}
echo " "
echo "Removing ${LIGHT_GRAY}${SITES}.sql ${NC}backup file from ${LIGHT_GRAY}webroot${NC}"
rm ${EE_PATH}/${SITES}/app/htdocs/${SITES}.sql
echo " "
echo "Changing ownership of ${LIGHT_GRAY}${BACKUP_DIR_C} ${NC}to ${LIGHT_GRAY}${CHOWN}${NC}"
chown -R root:root ${BACKUP_DIR_C}
echo " "
echo "${YELLOW}================= ${NC}[ ${RED}Finished ${NC}EasyEngine Backup Script by @CryptoSeb ] ${YELLOW}=================${NC}"
echo " "
echo " "
done

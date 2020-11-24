#!/bin/bash
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
EE_PATH="/opt/easyengine/sites/"
BACKUP_DIR_C="/root/ee-backups/"
BACKUP_PATH="/root"
DATE=`date +%Y-%m-%d`
SITE="example.com"
CHOWN="root:root"

PURPLE='\033[1;35m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHT_GREEN='\033[1;32m'
LIGHT_BLUE='\033[1;34m'
LIGHT_GRAY='\033[0;37m'
NC='\033[0m'

echo " "
echo " "
echo "${YELLOW}================= ${NC}[ ${LIGHT_GREEN}Starting ${NC}EasyEngine Backup Script by @CryptoSeb ] ${YELLOW}=================${NC}"
echo " "
echo "Making backup folder in ${LIGHT_GRAY}${BACKUP_PATH}${NC}"
mkdir -p ${BACKUP_DIR_C}${DATE}
echo "Backing up WordPress database to ${LIGHT_GRAY}webroot${NC}"
ee shell ${SITE} --command="wp db export ${SITE}.sql"
cp -r ${EE_PATH} ${BACKUP_DIR_C}${DATE}
echo "Removing ${LIGHT_GRAY}${SITE}.sql ${NC}backup file from ${LIGHT_GRAY}webroot${NC}"
rm ${EE_PATH}${SITE}/app/htdocs/${SITE}.sql
echo " "
echo "Changing ownership of ${LIGHT_GRAY}${BACKUP_DIR_C} ${NC}to ${LIGHT_GRAY}${CHOWN}${NC}"
chown -R root:root ${BACKUP_DIR_C}
echo " "
echo "${YELLOW}================= ${NC}[ ${RED}Finished ${NC}EasyEngine Backup Script by @CryptoSeb ] ${YELLOW}=================${NC}"
echo " "
echo " "

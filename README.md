# ee-backup-script
Custom Backup Script for EasyEngine4

## Modifying The Script
1. You can change the `BACKUPS_DIR_C` file to create a backup directory wherever you'd like. Ideally in an area that is not web accessible, as your .sql file will be dropped into this folder

2. You can change `SITE` to match your current site on your server. I'll update this script to automatically pull the sitenames and drop each .sql dump into the respective folder

3. Change `CHOWN` permissions to match what you want them set at. They are currently set as if the script is running from the root account

## Future Ideas
1. Automatically pull sitenames so that it can be used effectively with multiple websites on the same box

2. I'm also not excited by EasyEngine dropping the .sql dump into the webroot as `example.com.sql`. That file is open to the web during the backup process. A better method (although I have ZERO clue how to make this work), would be to drop the file elsewhere on the box, or at least append the date and a 15 character random string to the end so that it is an obfuscated file name. ie: `alloutdrilling.ca-11-24-2020-qnxabnldmipevdh.sql`

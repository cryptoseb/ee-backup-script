#!/bin/bash

# I had help with best-practice and formatting from sampersand[hashtag]8419.
# If you are a future employer, dont go looking at the version history, haha.

# Utility to crash with a message if something happens.
abort () { echo "$1" 1>&2; exit 1; }

# the `: ${varname:=default}` syntax allows the callers of this script to
# define the variables. if they aren't defined, the default values are used.
: "${ee_path:=/opt/easyengine/sites}"
: "${backup_dir_c:=/root/ee-backups/}"
: "${backup_path:=/root}"
: "${date:="$(date +%Y-%m-%d)"}"
: "${chown:=root:root}"

: "${site1:=saskseats.ca}"
: "${site2:=hurricanekids.ca}"
: "${site3:=example.com}"

    backup_dst="$backup_dir_c$date"

    # Print header.
    echo '================= [ Starting EasyEngine Backup Script by @CryptoSeb ] ================='

    # Create a backup folder.
    echo 
    echo "Making backup folder in: $backup_dst"
    mkdir -p "$backup_dst" || abort "unable to make backup dir '$backup_dst'."

    # Backup the FIRST WordPress database.
    echo 
    echo "Backing up WordPress database(s) to: webroot"
    ee shell "$site1" --command="wp db export $site1.sql" || abort 'EasyEngine db backup failed, see above'

    # Backup the SECOND WordPress database.
    # ee shell "$site2" --command="wp db export $site2.sql" || abort 'EasyEngine db backup failed, see above'

    # Copy all sites to '$backup_dst'
    echo
    echo "Copying sites to: $backup_dst"
    cp -r "$ee_path" "$backup_dst" || abort "unable to copy all files from '$ee_path' to '$backup_dst'."

    # Remove sql backup file for FIRST SITE from webroot.
    echo
    echo "Removing '$site1.sql' backup file from: webroot"
    rm_path="$ee_path/$site1/app/htdocs/$site1.sql"
    rm "$rm_path" || abort "unable to remove sql path: $rm_path."

    # Remove sql backup file for SECOND SITE from webroot.
    #echo
    #echo "Removing '$site2.sql' backup file from: webroot"
    # rm_path="$ee_path/$site1/app/htdocs/$site1.sql"
    # rm "$rm_path" || abort "unable to remove sql path: $rm_path."

    # change ownership of `backup_dir`.
    echo
    echo "Changing ownership of '$backup_dst' to: $chown"
    chown -R "$chown" "$backup_dst" || abort "unable to change owner to '$chown' for '$backup_dst'."

    # Print footer
    echo
    echo '================= [ Finished EasyEngine Backup Script by @CryptoSeb ] ================='

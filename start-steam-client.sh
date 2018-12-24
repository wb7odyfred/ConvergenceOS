#!/bin/bash
#
# Copyright (C) 2018  Jonathan Railsback
#
# This file is part of ConvergenceOS.
#
# ConvergenceOS is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation
#
# ConvergenceOS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ConvergenceOS.  If not, see <https://www.gnu.org/licenses/>.

function start_steam {
    pkill --signal 3 -f /home/steam/.steam/ubuntu12_32/steam
    sleep 5
    
    if [ "$DESKTOP_SESSION" != "cinnamon" ]; then
        export STEAM_FRAME_FORCE_CLOSE=0
    fi
    steam
}

if [ "$(whoami)" == "steam" ]; then
    DESKTOP_SESSION=$1
    start_steam
else
    STEAMOS_PID=$(pgrep steamos-session) 
    for STEAM_DESKTOP_PID in $(pgrep -f start-steam-client.sh); do 
        if [ "$STEAM_DESKTOP_PID" == "$$" ]; then
            STEAM_DESKTOP_PID=""
            continue
        else
            break    
        fi 
    done

    if [ "$STEAMOS_PID" == "" ] && [ "$STEAM_DESKTOP_PID" != "" ]; then
        zenity --info --width 250 --title "Start Desktop Steam Client" --text "Steam Desktop Client is already running"
        exit 0   
    fi

    if [ "$STEAMOS_PID" != "" ]; then
        zenity --question --width 300 --title "Start Desktop Steam Client" --text "SteamOS session is currently running.  Do you want to terminate it and start the Steam Desktop Client?  \n\nTerminating your SteamOS session will stop any ongoing downloads or Steam Cloud synchronization.  \n\nIf you choose to terminate your SteamOS session, it will be restarted automatically if you choose to return to SteamOS later."

        STOP_STEAMOS_OK=$?
        if [ "$STOP_STEAMOS_OK" == "1" ]; then
            exit 0
        fi

    fi

    xhost +
    # first check if we're already entered the admin password in this shell
    echo ${SUDO_PASSWORD} | sudo -S ls
    PASSWORD_OK=$?

    # if we havent already entered the password, get it
    if [ "$PASSWORD_OK" != "0" ]; then
        SUDO_PASSWORD=$(zenity --password --title "Start Steam Desktop Client")

        # now check that the entered password is OK
        echo ${SUDO_PASSWORD} | sudo -S ls
        PASSWORD_OK=$?

        if [ "$PASSWORD_OK" != "0" ]; then
            zenity --info --width 200 --text "Incorrect password entered" --title "Incorrect Password"
            exit 1
        fi
    fi

    # finally launch the steam desktop client
    echo ${SUDO_PASSWORD} | sudo -S su -c "$0 $DESKTOP_SESSION" steam
	
fi

exit 0




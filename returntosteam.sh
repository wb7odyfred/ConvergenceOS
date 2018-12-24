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

function switch_to_steamos {

    dbus-send --system --print-reply --dest=org.freedesktop.DisplayManager  /org/freedesktop/DisplayManager/Seat0 org.freedesktop.DisplayManager.Seat.SwitchToUser string:'steam' string:''

}

function force_quit_steam_desktop {

    local START_SCRIPT_PIDS=$(pgrep -f start-steam-client.sh)

    SUDO_PASSWORD=$(zenity --password --title "Force Quit Steam Client")

    echo ${SUDO_PASSWORD} | sudo -S ls
    PASSWORD_OK=$?

    if [ "$PASSWORD_OK" != "0" ]; then
        zenity --info --width 100 --text "Incorrect password"
        exit
    fi

    for PID in $START_SCRIPT_PIDS; do
        echo ${SUDO_PASSWORD} | sudo -S kill -9 $PID
    done

    echo ${SUDO_PASSWORD} | sudo -S pkill --signal 3 -f /home/steam/.steam/ubuntu12_32/steam

    # TODO: I think the PIDs dont exit instantly, so we should eventually replace this timeout with a check for the
    # PIDs instead    
    sleep 5

}


# get the desktop steam client pid
for PID in $(pgrep -f start-steam-client.sh); do break; done

if [ "$PID" != "" ]; then
    zenity --question --width 250 --title "Return to SteamOS" --text "Desktop Steam client is currently running.\n\nYou need to either exit your Desktop Steam client manually using the desktop interface, or force-quit the running Desktop instance before returning to SteamOS.\n\nNote that forcibly terminating your Steam Desktop Client may also terminate ongoing downloads or Steam Cloud synchronization" --ok-label="Exit Manually" --cancel-label="Force Quit"

    EXIT_MANUALLY=$?

    if [ "$EXIT_MANUALLY" == "0" ]; then
        exit
    else
        force_quit_steam_desktop
    fi
fi

switch_to_steamos


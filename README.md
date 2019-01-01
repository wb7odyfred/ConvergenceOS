# ConvergenceOS

## Disclaimer

ConvergenceOS is not affiliated with Valve, Steam, Ubuntu, or Linux Mint in any way. 

## Release

You can find binary releases of this program on GitHub at https://github.com/jonbitzen/ConvergenceOS/releases

## Overview

ConvergenceOS is a post-installer to turn a vanilla Ubuntu or Linux Mint installation into a SteamOS-like PC-based video game console, with the option to install secondary home-server functionality in the same manner you would do with either Ubuntu or Linux Mint.

Advantages of using ConvergenceOS include:

 - full, modern, and up-to-date package ecosystems from the Ubuntu package ecosystem; allows the user to easily install non-gaming functionality such as home theater PC software, home SMB shares, etc.

 - user control over drivers and versions, using standard driver management  tools and repositories

Please note that proprietary SteamOS components are NOT redistributed with this program.  They are installed by retrieving them from Valve's SteamOS repository.  Therefore an internet connection is absolutely necessary.

## Installing

When installing ConvergenceOS, please first install a fresh "vanilla" Ubuntu 18.04 or Linux Mint/Cinnamon 19 64 bit distribution on your machine.  Installing this on top of systems that you have already been running, whose configuration and packages may differ from the initial default Ubuntu/Mint install hasn't been tested, and is not recommended.

After installing a supported Linux distro, clone the ConvergenceOS repository into your home directory.  Enter the ConvergenceOS folder and type:

./build_convergence.sh

as the unpriviliged desktop user.  Do not start the program with administrator privileges - you will be asked for your administrator password later.

The program will configure your system to boot directly into the Steam Big Picture interface, as well as create some desktop icons that will allow you to manage your Steam session.

After installing Steam, the program will check your drivers, and install additional components as needed.

## Using the System

After installation, the system should boot into the Steam Big Picture interface.

From there, you can enable the Linux desktop in the settings to access your desktop.

In the desktop interface you will have two icons to manage your desktop and Steam sessions:

 * Return to SteamOS:  will exit your desktop session, and return you to the Steam Big Picture interface	

 * Steam Desktop Client:  will terminate the running SteamOS session, and start the Steam Desktop Client as the "steam" user (rather than the desktop user).  This will allow you to administer your SteamOS session in ways not available with the Big Picture interface, including:

	* choosing an alternate Steam game folder; for example you could boot from an SSD, and mount a large mechanical HDD to a folder, and use that for game storage (this also isolates your game folder from OS re-installation)

	* choosing SteamPlay Proton versions, enabling non-whitelisted games if desired

	* set game launcher args using the Steam desktop client to enable special functionality, or to allow the user to configure per-game workaround args

	* and so on and so forth

   Note that your SteamOS session will be restarted automatically when you click the Return to SteamOS icon.  Terminating the SteamOS session is necessary since only one instance of the Steam client can only be running at a time for a given user.
   

## Future Goals

 * Have a controller-friendly video game console-like greeter that will allow the user to launch game managers or stores other than Steam.  Also move the desktop administrator launcher to the greeter to perform home server and other   administrative tasks for all installed stores/game managers.

 * Offer a ConvergenceOS ISO, with post-installation features integrated into the normal distro installation program.
 
 * Create a node-based storage manager for games and media applications, which abstracts mount points (folders) as "pins" on nodes (storage devices); after setting pins on the nodes, the user should just connect source pins (folders on storage devices) to destination pins (mount points) to configure storage




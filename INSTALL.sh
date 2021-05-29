#!/bin/bash
BASEDIR=$(dirname $0)
KernelOS=$(uname)
UserName=$(whoami)

mkdir ~/.chromium/

cp $BASEDIR/Scripts/Remove\ Last\ Version.sh ~/.chromium/
cp $BASEDIR/Scripts/run.sh ~/.chromium/
cp $BASEDIR/Scripts/update.sh ~/.chromium/

cp -r $BASEDIR/Icons ~/.chromium/

mkdir ~/.chromium/State
mkdir ~/.chromium/Update_Data
mkdir ~/.local/share/applications

sudo touch ~/.local/share/applications/Chromium.desktop
sudo touch ~/.local/share/applications/Restore\ Chromium.desktop

clear
echo "Downloading..."
echo ""
bash ~/.chromium/update.sh >> /dev/null
clear

if [ $KernelOS == "Darwin" ]; then 
  ln -s ~/.chromium/latest/Chromium.app/ /Applications/Chromium.app 
  while [ "$(crontab -l | grep "* * * * 1 $HOME/.chromium/AutoUpdate.sh")" = "* * * * 1 $HOME/.chromium/AutoUpdate.sh" ] || [ "$AUTO" != "s" ] || [ "$AUTO" != "S" ]; do
    clear
    echo ""
    echo "  If you DON'T want to have autoupdates, press 'N' and Enter. Otherwise, press Enter"
    echo ""
    read AUTO
    if [  "$AUTO" = "n" ] || [ "$AUTO" = "N" ]; then bash ~/.chromium/run.sh & exit ; fi
    clear
    echo "Please add '* * * * 1 /Users/$(whoami)/.chromium/AutoUpdate.sh' Then press control+'o' and Enter and control+'x' without the double quotes. And now you can close the terminal. Press Enter"
    echo ""
    read PAUSE
    echo "Are you ready? Did you copy the line with Ctrl+'C'? Press Enter if it's true"
    echo ""
    read PAUSE
    export VISUAL=nano && crontab -e
  done
fi

if [ $KernelOS == "Linux" ]; then

  #CREATE CHROMIUM SHORTCUT
    sudo echo "[Desktop Entry] " > ~/.local/share/applications/Chromium.desktop
    sudo echo "Version=1.0 " >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Type=Application " >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Name=Chromium " >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Comment=Chromium Web Browser " >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Exec=chromium " >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Icon=/home/$UserName/.chromium/Icons/Chromium.png" >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Categories=Network;WebBrowser;" >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Path=/home/$UserName/.chromium" >> ~/.local/share/applications/Chromium.desktop
    sudo echo "Terminal=false " >> ~/.local/share/applications/Chromium.desktop
    sudo echo "StartupNotify=false " >> ~/.local/share/applications/Chromium.desktop
    
  #CREATE RESTORE CHROMIUM SHORTCUT
    sudo echo "[Desktop Entry]" > ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Version=1.0" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Type=Application" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Name=Restore Chromium" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Comment=Restore the Last Version of Chromium" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Exec=bash /home/$UserName/.Chromium/Remove\ Last\ Version.sh" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Icon=/home/$UserName/.Chromium/Icons/Restore Chromium.png" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Categories=Network;WebBrowser;" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Path=" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "Terminal=true" >> ~/.local/share/applications/Restore\ Chromium.desktop
    sudo echo "StartupNotify=true" >> ~/.local/share/applications/Restore\ Chromium.desktop

  sudo cp $BASEDIR/Scripts/Application /usr/bin/chromium
  sudo chmod +x /usr/bin/chromium
  sudo chmod +x ~/.local/share/applications/Chromium.desktop
  sudo chmod +x ~/.local/share/applications/Restore\ Chromium.desktop

  clear
  echo ""
  echo "  If you DON'T want to have autoupdates, press 'N' and Enter. Otherwise, press Enter"
  echo ""
  read AUTO
  if [  "$AUTO" = "n" ] || [ "$AUTO" = "N" ]; then bash ~/.chromium/run.sh & exit ; fi
  echo ""
  echo "  Please enter the password..."
  echo ""
  sudo cat "/var/spool/cron/crontabs/$(whoami)" > /tmp/chron 
  sudo echo "* * * * 1 $HOME/.chromium/AutoUpdate.sh" >> /tmp/chron
  sudo cp -r /tmp/chron "/var/spool/cron/crontabs/$(whoami)"
  sudo rm -r /tmp/chron
fi
 
bash ~/.chromium/run.sh &
exit

# Chromium Updater for Mac & Linux            ![image](https://user-images.githubusercontent.com/84420737/118993821-360ec700-b95c-11eb-8d6d-b07f7d79ff53.png)
### Welcome to the Open Source Chromium Browser!
This project is a fork from the original creator: scheib. And I have to say thanks to gamgi to give me the idea for the Mac OS implementation in the functionality of this script.
**With these scripts you can install and Update Chromium in your home directory in GNU/Linux and Mac OS X**. You must have the crontab installed for the automatic updates (Next function), have installed the function "notify-send" and have the folders of your home directory in English, otherwise you must edit the install script to change it for the name of your Desktop folder.
## Instalation:
  For the instalation you have to download this package and unzip it. After that you have to select the unziped folder, move it to ~/.Chromium (changing te name of that folder to ".chromium" and put it in your home directory) and from a terminal, execute this line of code:
```
cd ~/.chromium/
sudo bash ./update.sh
sudo bash ./run.sh
```
  And with this it installs chromium in ~/.Chromium and open it when it finalizes.

## Enable Automatically updates:
  If you're on Mac OS, you have to manually edit the crontab to enable automatic updates. If you're on GNU/Linux, you don't have to do it too, the script will do it automatically. Let's begin. First, you have to open a terminal and type the following:
  ```
  whoami
  ```
  You have to anote or remember that because we're going to use it later. Now type the following:
  ```
  sudo export VISUAL=nano; crontab -e
 ```
 It will open a command line text editor, so, if you have Mac OS you have to type this:
 ```
 * * * * 1 /Users/YOUR_USER/.chromium/AutoUpdate.sh
```
  Replacing "YOUR_NAME" with your username that said when you executed "whoami". Now you press control+'o' and Enter and control+'x' without the quotes. And now you can close it.

  If you don't want to edit your crontab or simply you want to update it manually, you can do it with this command whenever you want:
  ```
  bash ~/.chromium/update.sh
  ```

## Ready To Go!
Thank you! All the aportation and comments are good recived!.

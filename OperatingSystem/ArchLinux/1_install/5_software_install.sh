# kc0ver https://www.bilibili.com/read/cv20753052 
pacman -S archlinux-keyring
sudo pacman -S google-chrome
sudo pacman -S yay
yay -S jdk-openjdk
yay -S visual-studio-code-bin
yay -S intellij-idea-community-edition-no-jre

# get systeminfo through 'neofetch'
yay -S neofetch  

#https://bbs.archlinux.org/viewtopic.php?id=125308
echo 'install cmd hostname'
yay -S inetutils
yay -S net-tools

echo 'install work utils'
sudo pacman -S wemeet-bin 
sudo pacman -S wps-office

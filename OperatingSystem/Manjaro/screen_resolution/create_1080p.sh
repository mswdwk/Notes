# check 1080p 
has_1080p=$(xrandr -q|grep 1080 |grep 1920|grep -v grep|wc -l)
echo "has_1080p=$has_1080p"
_1080p=`sudo cvt 1920 1080|sed -n "2p"|cut -c 9-`

_1080p=expr echo ${_1080p}
#echo "1080p=${_1080p}"
# 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
#Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

#2) add newmode config
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
set -x
#xrandr --newmode ${_1080p}
#3) addmode
#sudo xrandr --addmode Virtual1 "1920x1080_60.00"
_1080p_name=$(echo $_1080p|cut -f 1 -d" ")
echo "1080p_name=${_1080p_name}"

sudo xrandr --addmode Virtual1 "1920x1080_60.00"

#4) set screen display mode
sudo xrandr --output Virtual1 --mode "1920x1080_60.00"

#5) show current display mode
xrandr -q

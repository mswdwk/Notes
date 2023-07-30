
#echo "[archlinuxcn]
#Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch" >> /etc/pacman.conf


cat <<EOF >> /etc/pacman.conf
[archlinuxcn]
#SigLevel = Never
Server = https://mirrors.bfsu.edu.cn/archlinuxcn/\$arch
EOF

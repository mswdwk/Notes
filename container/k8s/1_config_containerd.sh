# generate containerd default config
containerd config default > config_def.toml
# modify config_def.toml to config.toml
echo "change sandbox_image to the China mirror, config cgroup driver to 'systemd'"
# copy to the system
sudo cp config.toml /etc/containerd/config.toml
# restart
sudo systemctl restart containerd
sudo systemctl status containerd

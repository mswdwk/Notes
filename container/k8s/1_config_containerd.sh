# generate containerd default config
containerd config default > config_def.toml
# modify config_def.toml to config.toml

echo "Change sandbox_image to the China mirror, sandbox_image = \"registry.aliyuncs.com/google_containers/pause:3.9\""
echo "Config cgroup driver to 'systemd'"

# copy to the system
echo "in file config.toml, make sure: systemd_cgroup = true "
echo "in file config.toml, make sure: SystemdCgroup = true "

sudo cp config.toml /etc/containerd/config.toml
# restart
sudo systemctl restart containerd
sudo systemctl status -l containerd

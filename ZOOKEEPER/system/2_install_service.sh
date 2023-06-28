sudo cp ./zookeeper.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable zookeeper
sudo systemctl start zookeeper
sudo systemctl status zookeeper

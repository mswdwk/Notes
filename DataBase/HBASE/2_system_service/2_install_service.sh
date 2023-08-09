sudo cp ./hbase.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable hbase
sudo systemctl start hbase
sudo systemctl status hbase

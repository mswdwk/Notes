# make sure node1/2/3 server generated its own ssh key file. 
# for other words, there is ~/.ssh/id_rsa.pub on node1/2/3.
# on Node1
ssh-copy-id user@node1
ssh-copy-id user@node2
ssh-copy-id user@node3
echo "copy local file 'authorized_keys' to server node2/3 "
scp ~/.ssh/authorized_keys user@node2:~/.ssh/
scp ~/.ssh/authorized_keys user@node3:~/.ssh/

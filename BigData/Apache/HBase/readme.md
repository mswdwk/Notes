config password-less login on node1/2/3.
# Method 1
## On Node1 
ssh-copy-id user@node1
ssh-copy-id user@node2
ssh-copy-id user@node3
## On Node2 
ssh-copy-id user@node1
ssh-copy-id user@node2
ssh-copy-id user@node3
## On Node3 
ssh-copy-id user@node1
ssh-copy-id user@node2
ssh-copy-id user@node3

# Method 2 
## On Node1 
ssh-copy-id user@node1
ssh-copy-id user@node2
ssh-copy-id user@node3
echo "copy file 'authorized_keys' to node2/3"
scp ~/.ssh/authorized_keys user@node2:~/.ssh/
scp ~/.ssh/authorized_keys user@node3:~/.ssh/

echo "On Node 1"
echo "for node1 to node2,3"
ssh-copy-id user@node2
ssh-copy-id user@node3
chmod 0600 ~/.ssh/authorized_keys

echo "for node2 to node3"
ssh user@node3 "bash -s" <<ENDSSH
 ssh-copy-id user@node3
 chmod 0600 ~/.ssh/authorized_keys
ENDSSH

echo "for node3 to node2"
ssh user@node2 "bash -s" <<ENDSSH
ssh-copy-id user@node3
 chmod 0600 ~/.ssh/authorized_keys
ENDSSH


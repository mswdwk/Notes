 mkdir -pv certs/{CA,client,server}
 touch certs/index.txt
 touch certs/serial
 echo "1000" >  certs/serial
 echo "unique_subject = no" > certs/index.txt.attr  # Sign multiple certs for the same CN

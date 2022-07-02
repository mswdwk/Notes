#start pulseaudio server right now
pulseaudio --start 
#add pulseaudio service
sudo systemctl edit --force --full pulseaudio.service

CONTAINER=$1
sudo less -F `sudo docker inspect --format='{{.LogPath}}' $CONTAINER`

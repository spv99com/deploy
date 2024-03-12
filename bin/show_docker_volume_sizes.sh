v=`sudo docker volume ls -q`
dp="/var/lib/docker/volumes"
for dv in $v
do
  echo "Volume $dv"
  sudo du -s --block-size=M $dp/$dv/_data
done
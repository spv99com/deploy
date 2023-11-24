# The script will create a backup of each database in the mongo container
# The backup will be named mongo_<db_name>_<timestamp>.tar.gz and will be placed in the host's /mnt/backup_mongo directory
# You can run this script as often as you want or place it in a cron job

container=jozef-mongo-mongo-1
docker=/usr/bin/docker
sudo=/usr/bin/sudo

backup_mongo_db(){
  local db_name=$1
  local dt=$(date '+%Y-%m-%d_%H-%M-%S')
  $sudo $docker container exec -i -t $container mongodump --db=${db_name} --gzip --archive=/backup/mongo_${db_name}_${dt}.tar.gz -v
}

get_dbs(){
  $sudo $docker container exec -i -t $container mongosh --quiet --eval 'db.getMongo().getDBNames().forEach(b=>print(b))'
}

dbs=`get_dbs`
for db in $dbs
do
  # strip non printable characters
  db="${db%%[[:cntrl:]]}"
  echo "> backing database $db up"
  backup_mongo_db $db
done
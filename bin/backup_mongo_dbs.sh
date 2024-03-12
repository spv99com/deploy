# The script will create a backup of each database in the mongo container
# The backup will be named mongo_<db_name>_<timestamp>.tar.gz and will be placed in the host's /mnt/backup_mongo directory
# You can run this script as often as you want or place it in a cron job

set -o allexport
source .env
set +o allexport

[[ -z $MONGO_CONTAINER ]] && echo "MONGO_CONTAINER is not set" && exit 1
[[ -z $DB_URL ]] && echo "DB_URL is not set" && exit 1
[[ -z $BACKUP_DIR ]] && echo "BACKUP_DIR is not set" && exit 1

docker=/usr/bin/docker
sudo=/usr/bin/sudo

backup_mongo_db(){
  local db_name=$1
  local dt=$(date '+%Y-%m-%d_%H-%M-%S')
  $sudo $docker container exec -i -t $MONGO_CONTAINER mongodump --uri="$DB_URL" --db=${db_name} --gzip --archive=${BACKUP_DIR}/mongo_${db_name}_${dt}.tar.gz
}

get_dbs(){
  $sudo $docker container exec -i -t $MONGO_CONTAINER mongosh "$dburi" --quiet --eval 'db.getMongo().getDBNames().forEach(b=>print(b))'
}

dbs=`get_dbs`
echo $dbs

echo Following databases will be excluded
echo $EXCLUDE_DBS

for db in $dbs
do
  # strip non printable characters
  db="${db%%[[:cntrl:]]}"

  if [[ "$EXCLUDE_DBS" =~ "$db" ]]; then
    echo "> excluding $db ..."
    continue
  fi

  echo "> backing database $db ...."
  backup_mongo_db $db
done
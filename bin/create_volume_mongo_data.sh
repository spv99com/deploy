# This script creates a docker volume for mongo data
# It shall be used only once, when the mongo container is created for the first time

vol_type=ext4
# block device
vol_device=/dev/disk/by-id/scsi-0HC_Volume_100109400
# volume name
vol_name=mongo_data

sudo docker volume create --driver local --opt type=$vol_type --opt device=$vol_device $vol_name
# This script creates a docker volume for redis data
# It shall be used only once, when the redis container is created for the first time

vol_device=/mnt/HC_Volume_100104348/redis_data
# volume name
vol_name=redis_data

sudo docker volume create --opt type=none --opt o=bind --opt device=$vol_device $vol_name
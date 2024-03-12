# Deployment of SPV99 apps

## Prerequisites
1. ubuntu server
2. docker
3. access to DNS

## Initialize
1. clone the repository
2. navigate to the root folder
3. create docker networks
    ```bash
    bin/create_networks.sh
    ```
4. create docker volumes
    ```bash
    bin/create_volume_mongo_data.sh
    bin/create_volume_redis_data.sh
    ```
5. start mongo and redis containers from their folders
    ```bash
    cd mongo
    docker compose up -d
    cd ../redis
    docker compose up -d
    ```


## Proxy
Project proxy is based on nginx. It is used to redirect traffic to the right container. 
It creates containers for nginx and acme.sh. Acme.sh is used to generate SSL certificates from Let's Encrypt.

### Installation
1. configure DNS to point to the server
1. navigate to `proxy` folder
2. run `docker compose up -d`


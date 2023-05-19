# Deployment of SPV99 apps

## Prerequisites
1. ubuntu server
2. docker
3. access to DNS

## Proxy
Project proxy is based on nginx. It is used to redirect traffic to the right container. 
It creates containers for nginx and acme.sh. Acme.sh is used to generate SSL certificates from Let's Encrypt.

### Installation
1. configure DNS to point to the server
1. navigate to `proxy` folder
2. run `docker compose up -d`

## Dedotrader
Dedotrader is a trading bot/app for Binance exchange. 

### Installation
1. navigate to `dedotrader` folder
2. copy `env.example` to `.env` and fill in the values
2. run `docker compose up -d`

## Update
1. navigate to `dedotrader` folder
2. run `docker compose pull`
3. run `docker compose up -d`

## Tools

* Run debian bash in the container: `sudo docker run -i -t debian bash`
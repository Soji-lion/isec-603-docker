#!/bin/bash

sudo docker load -i ./images/internal_host.tar
#sudo docker load -i ./images/juice_shop.tar
sudo docker load -i ./images/kali.tar
sudo docker load -i ./images/router.tar
sudo docker compose up

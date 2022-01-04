#!/bin/bash

echo "Updating"
apt update
apt upgrade

echo "Installing GIT"
apt install -y git
git --version

echo "Configuring GIT"
mkdir git && cd git
git init
git remote add origin https://github.com/iSTKr/Symphony_test.git
git pull origin main

echo "Installing Docker"
apt install -y docker.io
docker --version

echo "Configuring Docker"
cd /git/infra
docker build -t apache .
docker run --name apache2 -d -p 80:80 apache


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

#echo "Downloading actions-runner"
#cd /
#mkdir actions-runner && cd actions-runner
#curl -o actions-runner-linux-x64-2.285.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.285.1/actions-runner-linux-x64-2.285.1.tar.gz
#echo "5fd98e1009ed13783d17cc73f13ea9a55f21b45ced915ed610d00668b165d3b2  actions-runner-linux-x64-2.285.1.tar.gz" | shasum -a 256 -c
#tar xzf ./actions-runner-linux-x64-2.285.1.tar.gz

#echo "Configuring actions-runner"
#./config.sh --url https://github.com/iSTKr/Symphony_test --token AXB5DQ772M37V5I5SYHBAP3B2RI2K
#./run.sh


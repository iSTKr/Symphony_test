#!/bin/bash
sudo terraform apply
sudo terraform output ec2instance_dns > ec2_dns_name
#sudo cp ec2_dns_name home/stk/symphony_test/git/main/infra/ec2_dns_name
read -t 70 -p "Please, wait a minute before pushing...
"
cd home/stk/symphony_test/git/main && ./git_push

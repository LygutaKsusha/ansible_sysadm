#!/bin/bash

#Install ansible
yum install -y epel-release ansible

sleep 2


for i in `cat servers`;
do
  sshpass -p admin ssh-copy-id -i ~/.ssh/id_rsa-remote-ssh.pub -o StrictHostKeyChecking=no -p 22 admin@$i
done

sleep 

ansible-playbook -i inventory/hosts.ini servers.yml  -b -v 

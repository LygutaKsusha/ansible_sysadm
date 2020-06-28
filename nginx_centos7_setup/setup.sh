#!/bin/bash

echo -e "
################################################################################
################################################################################
#                                                                              #
#                                                                              #
#                                                                              #
#                 \e[34mWelcome to CentOS Installer\e[39m                      #
#                                                                              #
#                                                                              # 
#                                                                              #
#                                                                              #
################################################################################
################################################################################"


readUser(){
   echo "Type the username you would like to add, followed by [ENTER]:"
   read USERNAME 

   if [ -n "$USERNAME" ]; then
   	  addUser $USERNAME
   else 
      echo "Please enter valid username" 
      readUser
   fi
}

addUser(){
	echo "Adding $USERNAME user"
	useradd $1
	passwd $1

	echo "Adding user:$USERNAME to sudoers\n"
	usermod $USERNAME -aG wheel
}


setDomainName(){
   echo "Type the Domain name you would like to configure, followed by [ENTER]:"
   read HOST

   if [ -n "$HOST" ]; then
   	  echo "Setting Hostname: $host"
   	  hostname $HOST
   	else
   	  echo "Please enter valid hostname"
   	  setDomainName
   	fi
}

installOSDependencies(){

	echo "Installing Repos\n"
	yum install epel-release -y

	echo "Updating repos\n"
	yum update -y
}

changeSELinuxSetting(){
    echo "Changing SELinux Settings\n"
    sed -i 's/enforcing/disabled/g' /etc/selinux/config

    echo "Enabling SELinux Disabled config\n"
    sestatus
    setenforce 0
}

setTimeZone(){
	echo "Type the timezone for server. Example of valid timezone Asia/Kolkata, followed by [ENTER]:"
	read TIMEZONE 

	echo "Setting up timezone to $TIMEZONE\n"
	TIMEZONEPATH="/usr/share/zoneinf/$TIMEZONE"
	rm /etc/localtime
	ln -s $TIMEZONEPATH /etc/localtime
}


installDependencies(){
	echo "Installing nginx wget tar nano"
	yum install nginx tar wget nano htop -y
}


setupNginxConf(){
	systemctl enable nginx
	systemctl start nginx 
}

# Start script

readUser

setDomainName

installOSDependencies

changeSELinuxSetting

configureFirewall

setTimeZone

installDependencies

setupNginxConf

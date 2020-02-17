#!/usr/bin/env bash 
echo 'export PS1="\e[1;32m[🌞🌲\u@\h🌲🌞\e[0;37m \w]\$ \e[m"' >> /home/vagrant/.bashrc
echo 'export PS1="\e[1;31m[🥶\u@\h🥶:\e[1;37m\w\e[1;31m]\e[1;31m\e[0;37m#\e[m "' >> /root/.bashrc

#timedatectl set-timezone America/New_York
#dnf install -y xauth firefox httpd net-tools
#systemctl enable --now firewalld.service
#yum install -C -y /vagrant/rpms/*
#yum install -C -y /vagrant/rpms/xauth

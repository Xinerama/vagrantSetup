#!/usr/bin/env bash 
echo 'export PS1="\e[1;32m[🌞🌲\u@\h🌲🌞\e[0;37m \w]\$ \e[m"' >> /home/vagrant/.bashrc
echo 'export PS1="\e[1;31m[🥶\u@\h🥶:\e[1;37m\w\e[1;31m]\e[1;31m\e[0;37m#\e[m "' >> /root/.bashrc

#timedatectl set-timezone America/New_York
#dnf install -y xauth firefox httpd net-tools
#systemctl enable --now firewalld.service
#yum install -C -y /vagrant/rpms/*

# Install the necessary packages for the nfs server
yum install -C -y /vagrant/rpms/nfs-utils



# Start and Enable the needed services
systemctl enable --now nfs-server

# Create the export filesystem using mkdir
mkdir -p /srv/nfs4/{backups,www}
mkdir /opt/backups
mkdir /var/www

# Mount the actual directories
mount --bind /opt/backups /srv/nfs4/backups
mount --bind /var/www /srv/nfs4/www

# Make the mountpoints permanent
echo "/opt/backups /srv/nfs4/backups  none   bind   0   0" >> /etc/fstab
echo "/var/www     /srv/nfs4/www      none   bind   0   0" >> /etc/fstab

# Add entries to /etc/exports file
echo "/srv/nfs4         10.0.2.15/24 (rw,sync,no_subtree_check,crossmnt,fsid=0)" >> /etc/exports
echo "/srv/nfs4/backups 10.0.2.15/24 (ro,sync,no_subtree_check) 192.168.33.3(rw,sync,no_subtree_check)" >> /etc/exports
echo "/srv/nfs4/www     10.0.2.15/24 (rw,sync,no_subtree_check)" >> /etc/exports
exportfs -ra

# #10.0.2.15/24

# Setup firewall rules
sudo firewall-cmd --new-zone=nfs --permanent
sudo firewall-cmd --zone=nfs --add-service=nfs --permanent
sudo firewall-cmd --zone=nfs --add-source=10.0.2.15/24 --permanent
sudo firewall-cmd --reload



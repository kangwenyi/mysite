#!/bin/bash
#
#
###############################
#引导服务器，DHCP地址
ServerIP="192.168.1.1"

rpm -Uvh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum -y install dhcp tftp  xinetd httpd cobbler
sed -i "s/^server: 127.0.01/server: ${ServerIP}/g" -e "s/^next_server: 127.0.01/server: ${ServerIP}/g" -e 's/^manage_dhcp: 0/manage_dhcp: 1/g' /etc/cobbler/settings
#/etc/init.d/cobbler start && /etc/init.d/cobbler start
cobbler get-loaders
sed -i 's/disable = no/disable = yes/g' /etc/xinetd.d/tftp
#执行这步之前需要把ISO挂载到/opt/iso目录下
cobbler import --path=/opt/iso --name=CentOS_6.4

sed -n '/ddns/,/#for/p' /etc/cobbler/dhcp.template >> /etc/dhcp/dhcpd.conf

/etc/init.d/httpd start
/etc/init.d/xinetd start 
/etc/init.d/dhcpd start
/etc/init.d/cobblerd start


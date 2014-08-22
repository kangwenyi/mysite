1， 安装epel,安装cobbler和依赖包
	rpm -Uvh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
	yum -y install dhcp tftp  xinetd httpd cobbler

2	配置
		启动cobbler,http
		/etc/init.d/cobbler start
		/etc/init.d/cobbler start
		如果启动httpd的时候报端口被占用可以修改httpd.conf 和/etc/cobbler/settings文件，来修改服务端口
		启动之后需要检查下配置文件
			cobbler check  
		打完这个命令会出来大概 7，8条的提示信息，这时候你需要执行下面那3步
		1.编辑/etc/cobbler/settings文件以，找到 server、next_server这两选项，修改为本机IP
		2.编辑/etc/cobbler/settings文件以，找到manage_dhcp 修改为1、
		3.修改完以上3处之后需要执行下cobbler get-loaders这个命令，这个命令必须在可以连网的情况下执行
		4.将 /etc/xinetd.d/tftp 中 disable = no
		5.导入ISO文件 	cobbler import --path=/opt/iso --name=CentOS_6.4
		6.查看导入结果	cobbler distro list
		7.复制/etc/cobbler/dhcp.template这个里面的内容到/etc/dhcp/dhcpd.conf里面
			ddns-update-style interim;
			allow booting;
			allow bootp;
			ignore client-updates;
			set vendorclass = option vendor-class-identifier;
			option pxe-system-type code 93 = unsigned integer 16;
			subnet 192.168.1.0 netmask 255.255.255.0 {
     			option routers             192.168.1.1;	#路由器地址  
     			option domain-name-servers 192.168.1.1;	 #DNS地址  
     			option subnet-mask         255.255.255.0;	#子网掩码选项
     			range dynamic-bootp        192.168.1.200 192.168.1.254; 	#动态IP范围
     			default-lease-time         21600;
     			max-lease-time             43200;
     			next-server                192.168.1.79;	#指定引导服务器 
     			class "pxeclients" {
          			match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
          			if option pxe-system-type = 00:02 {
                  		filename "ia64/elilo.efi";
          			} else if option pxe-system-type = 00:06 {
                  		filename "grub/grub-x86.efi";
          			} else if option pxe-system-type = 00:07 {
                  		filename "grub/grub-x86_64.efi";
          			} else {
                  		filename "pxelinux.0";
          			}
   		    	}

			}
			8，然后重启各服务
				/etc/init.d/httpd start
				/etc/init.d/xinetd start 
				/etc/init.d/dhcpd start
				/etc/init.d/cobblerd start
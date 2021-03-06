#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#=================================================================#
#   System Required:  CentOS 6,7, Debian, Ubuntu                  #
#   Description: One click Install UML for bbr+ssr                #
#=================================================================#



# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Error:This script must be run as root!" 1>&2
   exit 1
fi


if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo "Not support OS, Please reinstall OS and retry!"
    exit 1	
fi

function getversion(){
    if [[ -s /etc/redhat-release ]];then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else    
        grep -oE  "[0-9.]+" /etc/issue
    fi    
}
ver=""
centosversion() {
    if [ "${release}" == "centos" ]; then
        local version="$(getversion)"
        local main_ver=${version%%.*}
		ver=$main_ver
    else
        return 1
    fi
}
centosversion
if [[ "$release" = "centos" && "$ver" = "6" ]]; then
	wget -N --no-check-certificate https://raw.githubusercontent.com/wn789/OpenVZ-BBR/master/bbr/centos6.sh && bash centos6.sh
elif [[ "$release" = "centos" && "$ver" = "7" ]]; then
	wget -N --no-check-certificate https://raw.githubusercontent.com/wn789/OpenVZ-BBR/master/bbr/centos7.sh && bash centos7.sh
elif [[ "$release" = "ubuntu" ]]; then
	wget -N --no-check-certificate https://raw.githubusercontent.com/wn789/OpenVZ-BBR/master/bbr/ubuntu.sh && bash ubuntu.sh
elif [[ "$release" = "debian" ]]; then
	wget -N --no-check-certificate https://raw.githubusercontent.com/wn789/OpenVZ-BBR/master/bbr/ubuntu.sh && bash ubuntu.sh	
fi	







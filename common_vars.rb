# -*- mode: ruby -*-
# vi: set ft=ruby :


# # changing vagrant UID and GID
# $fix_vagrant_user = <<SCRIPT
# echo "Fixing vagrant UID and GID (1000 -> 500)"
# set -xe
# chown -R 500:500 /home/vagrant
# # since it is just a VM, we can be careless
# sed -i 's/1000/500/g' /etc/group
# sed -i 's/1000/500/g' /etc/passwd
# #cat /etc/passwd
# find / -path /proc -prune -false -o -user 1000 | xargs chown -h 500
# find / -path /proc -prune -false -o -group 1000 | xargs chgrp -h 500
# SCRIPT

# common settings on all machines
$etc_hosts = <<SCRIPT
echo etc_hosts
set -xe
cat <<END > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.0.4.6 mds01
10.0.4.8 oss01
10.0.4.9 oss02
10.0.4.50 cl0
10.0.4.51 cl1
10.0.4.52 cl2
10.0.4.53 cl3
10.0.4.54 cl4
10.0.4.55 cl5
10.0.4.56 cl6
10.0.4.57 cl7
10.0.4.58 cl8
END
SCRIPT

# [Errno 14] problem making ssl connection
$yum_problem_making_ssl_connection = <<SCRIPT
echo yum_problem_making_ssl_connection
set -xe
# [Errno 14] problem making ssl connection
yum -y update nss* ca-certificates pycurl
yum clean all
SCRIPT



## Lustre settings
  
# disable IPv6 on Linux
$linux_disable_ipv6 = <<SCRIPT
echo linux_disable_ipv6
set -xe
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
SCRIPT

# setenforce 0
$setenforce_0 = <<SCRIPT
echo setenforce_0
set -xe
if test `getenforce` = 'Enforcing'; then setenforce 0; fi
#sed -Ei 's/^SELINUX=.*/SELINUX=Permissive/' /etc/selinux/config
SCRIPT

# stop iptables
$service_iptables_stop = <<SCRIPT
echo service_iptables_stop
set -xe
service iptables stop
SCRIPT

# stop firewalld.service
$systemctl_stop_firewalld = <<SCRIPT
echo systemctl_stop_firewalld
set -xe
systemctl stop firewalld.service
SCRIPT

# # changing vagrant UID and GID
# $fix_vagrant_user = <<SCRIPT
# echo "Fixing vagrant UID and GID"
# set -xe
# chown -R 1000:1000 /home/vagrant
# sed 's/500/1000/g' /etc/group | sudo tee /etc/group
# sed 's/500/1000/g' /etc/passwd | sudo tee /etc/passwd
# find / -path /proc -prune -false -o -user 500 | xargs chown -h 1000
# find / -path /proc -prune -false -o -group 500 | xargs chgrp -h 1000
# SCRIPT


$epel7 = <<SCRIPT
set -xe
# yum -y install epel-release
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
SCRIPT

$create_repo_lustre_server = <<SCRIPT
echo create_repo_lustre_server
set -xe
yum clean all
cat <<'END' > /etc/yum.repos.d/lustre-server.repo
[lustre-server]
name=lustre-server
minrate=0
timeout=300
baseurl=https://downloads.whamcloud.com/public/lustre/lustre-2.12.4/el7.7.1908/server
gpgcheck=0
END
SCRIPT

$create_repo_lustre_client = <<SCRIPT
echo lustre_client_rhel
set -xe
yum clean all
cat <<'END' > /etc/yum.repos.d/lustre_client.repo
[lustre-client]
name=lustre-client
minrate=0
timeout=300
baseurl=https://downloads.whamcloud.com/public/lustre/lustre-2.12.4/el$releasever/client/
gpgcheck=0
[vault]
name=CentOS-vault
minrate=0
timeout=300
baseurl=https://vault.centos.org/7.7.1908/os/x86_64/
gpgcheck=1
[vault-updates]
name=CentOS-vault-updates
minrate=0
timeout=300
baseurl=https://vault.centos.org/7.7.1908/updates/x86_64/
gpgcheck=1
END
SCRIPT

# e2fsprogs
# https://groups.google.com/forum/#!topic/lustre-discuss-list/U93Ja6Xkxfk
$create_repo_e2fsprogs = <<SCRIPT
echo e2fsprogs_rhel
set -xe
yum clean all
cat <<'END' > /etc/yum.repos.d/e2fsprogs.repo
[e2fsprogs-wc]
name=e2fsprogs-wc
baseurl=https://downloads.whamcloud.com/public/e2fsprogs/latest/el7
gpgcheck=0
minrate=0
timeout=300
END
SCRIPT

# CentOS vault (specific version of the kernel needed by lustre)
$create_repo_centos_vault = <<SCRIPT
echo centos_vault
set -xe
RELEASE=$1
yum clean all
cat <<END > /etc/yum.repos.d/vault.repo
[vault]
name=CentOS-vault
baseurl=http://vault.centos.org/$RELEASE/os/\\$basearch/
gpgcheck=1
[vault-updates]
name=CentOS-vault-updates
baseurl=http://vault.centos.org/$RELEASE/updates/\\$basearch/
gpgcheck=1
END
SCRIPT

$etc_modprobe_d_lnet = <<SCRIPT
echo etc_modprobe_d_lnet
set -xe
echo "options lnet networks=tcp0(eth1)" >> /etc/modprobe.d/lnet.conf
SCRIPT

# lustre mounts
$etc_fstab_lustre = <<SCRIPT
echo etc_fstab_lustre
set -xe
dev=$1
mnt=$2
options=$3
echo ${dev}, ${mnt}, ${options}
mkdir -p ${mnt}
cat <<END >> /etc/fstab
${dev}        ${mnt}        lustre  ${options}     0       0
END
SCRIPT

$install_prerequesites_server = <<SCRIPT
echo install_prerequesites_server
set -xe
yum install -y \
    perl
yum clean all
SCRIPT

# lustre kernel/firmware - install
$install_lustre_server_kernel = <<SCRIPT
echo lustre_server_kernel_install
set -xe
# kernel_version=`yum list --showduplicates kernel | grep lustre-server | awk '{print $2}'`
# kernel_firmware_version=`yum list --showduplicates kernel-firmware | grep lustre-server | awk '{print $2}'`
# yum -y install --nogpgcheck --setopt=protected_multilib=false kernel-${kernel_version} kernel-firmware-${kernel_firmware_version} kernel-devel-${kernel_version} kernel-headers-${kernel_version}
yum --nogpgcheck --disablerepo=base,extras,updates \
    --enablerepo=lustre-server install -y \
    kernel \
    kernel-devel \
    kernel-headers \
    kernel-tools \
    kernel-tools-libs \
    kernel-tools-libs-devel
yum clean all
SCRIPT


$install_lustre_client_kernel = <<SCRIPT
echo lustre_client_kernel_install
set -xe
VER="3.10.0-1062.9.1.el7"
yum -y remove kernel-tools-libs kernel-tools
yum -y --disablerepo=* --enablerepo=vault-updates install \
    kernel-$VER \
    kernel-devel-$VER \
    kernel-headers-$VER \
    kernel-abi-whitelists-$VER \
    kernel-tools-$VER \
    kernel-tools-libs-$VER \
    kernel-tools-libs-devel-$VER

SCRIPT


$kernel_version_lock = <<SCRIPT
echo kernel_version_lock
set -xe
yum versionlock add kernel
yum versionlock add kernel-devel
yum versionlock add kernel-headers
SCRIPT

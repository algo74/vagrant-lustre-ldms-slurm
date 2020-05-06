# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  # mds01
  config.vm.define "mds01" do |mds01|
    mds01.vm.box = "puppetlabs/centos-6.6-64-nocm"
    mds01.vm.box_url = 'puppetlabs/centos-6.6-64-nocm'
    # installing lustre kernel removes virtualbox guest additions
    mds01.vm.synced_folder ".", "/vagrant", disabled: true
    mds01.vm.network "private_network", ip: "10.0.4.6"
    mds01.vm.provider "virtualbox" do |v|
      v.memory = 256  # lustre is greedy and segfaults with small RAM
      # https://jira.hpdd.intel.com/browse/LU-5697
      v.cpus = 1
    end
    mds01.vm.provider "virtualbox" do |vb|
      if !File.exist?("mgt01.vdi")
        vb.customize ["createhd", "--filename", "mgt01.vdi", "--size", 64, "--variant", "Fixed"]
        vb.customize ["modifyhd", "mgt01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 0, "--device", 1, "--type", "hdd", "--medium", "mgt01.vdi"]
      if !File.exist?("mdt01.vdi")
        vb.customize ["createhd", "--filename", "mdt01.vdi", "--size", 128, "--variant", "Fixed"]
        vb.customize ["modifyhd", "mdt01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "mdt01.vdi"]
    end
  end
  # mds02
  config.vm.define "mds02" do |mds02|
    mds02.vm.box = "puppetlabs/centos-6.6-64-nocm"
    mds02.vm.box_url = 'puppetlabs/centos-6.6-64-nocm'
    # installing lustre kernel removes virtualbox guest additions
    mds02.vm.synced_folder ".", "/vagrant", disabled: true
    mds02.vm.network "private_network", ip: "10.0.4.7"
    mds02.vm.provider "virtualbox" do |v|
      v.memory = 256  # lustre is greedy and segfaults with small RAM
      # https://jira.hpdd.intel.com/browse/LU-5679
      v.cpus = 1
    end
    mds02.vm.provider "virtualbox" do |vb|
      if !File.exist?("mgt01.vdi")
        vb.customize ["createhd", "--filename", "mgt01.vdi", "--size", 64, "--variant", "Fixed"]
        vb.customize ["modifyhd", "mgt01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 0, "--device", 1, "--type", "hdd", "--medium", "mgt01.vdi"]
      if !File.exist?("mdt01.vdi")
        vb.customize ["createhd", "--filename", "mdt01.vdi", "--size", 128, "--variant", "Fixed"]
        vb.customize ["modifyhd", "mdt01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "mdt01.vdi"]
    end
  end
  # oss01
  config.vm.define "oss01" do |oss01|
    oss01.vm.box = "puppetlabs/centos-6.6-64-nocm"
    oss01.vm.box_url = 'puppetlabs/centos-6.6-64-nocm'
    # installing lustre kernel removes virtualbox guest additions
    oss01.vm.synced_folder ".", "/vagrant", disabled: true
    oss01.vm.network "private_network", ip: "10.0.4.8"
    oss01.vm.provider "virtualbox" do |v|
      v.memory = 256  # lustre is greedy and segfaults with small RAM
      # https://jira.hpdd.intel.com/browse/LU-5697
      v.cpus = 1
    end
    oss01.vm.provider "virtualbox" do |vb|
      if !File.exist?("ost01.vdi")
        vb.customize ["createhd", "--filename", "ost01.vdi", "--size", 768, "--variant", "Fixed"]
        vb.customize ["modifyhd", "ost01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "ost01.vdi"]
      if !File.exist?("ost02.vdi")
        vb.customize ["createhd", "--filename", "ost02.vdi", "--size", 768, "--variant", "Fixed"]
        vb.customize ["modifyhd", "ost02.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 1, "--type", "hdd", "--medium", "ost02.vdi"]
    end
  end
  # oss02
  config.vm.define "oss02" do |oss02|
    oss02.vm.box = "puppetlabs/centos-6.6-64-nocm"
    oss02.vm.box_url = 'puppetlabs/centos-6.6-64-nocm'
    # installing lustre kernel removes virtualbox guest additions
    oss02.vm.synced_folder ".", "/vagrant", disabled: true
    oss02.vm.network "private_network", ip: "10.0.4.9"
    oss02.vm.provider "virtualbox" do |v|
      v.memory = 256  # lustre is greedy and segfaults with small RAM
      # https://jira.hpdd.intel.com/browse/LU-5697
      v.cpus = 1
    end
    oss02.vm.provider "virtualbox" do |vb|
      if !File.exist?("ost01.vdi")
        vb.customize ["createhd", "--filename", "ost01.vdi", "--size", 768, "--variant", "Fixed"]
        vb.customize ["modifyhd", "ost01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "ost01.vdi"]
      if !File.exist?("ost02.vdi")
        vb.customize ["createhd", "--filename", "ost02.vdi", "--size", 768, "--variant", "Fixed"]
        vb.customize ["modifyhd", "ost02.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 1, "--type", "hdd", "--medium", "ost02.vdi"]
    end
  end
  

  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # client client
  (0..8).each do |c_idx|
    config.vm.define "cl#{c_idx}" do |client|
      client.vm.box = "basenode"
      client.vm.box_url = '~/vc/basenode/basenode'
      client.vm.synced_folder "xch", "/xch"
      client.vm.network "private_network", ip: "10.0.4.5#{c_idx}"
      client.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end
  end
  # =====================================================================================================

  
  # disable IPv6 on Linux
  $linux_disable_ipv6 = <<SCRIPT
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
SCRIPT
  # setenforce 0
  $setenforce_0 = <<SCRIPT
if test `getenforce` = 'Enforcing'; then setenforce 0; fi
#sed -Ei 's/^SELINUX=.*/SELINUX=Permissive/' /etc/selinux/config
SCRIPT
  # stop iptables
  $service_iptables_stop = <<SCRIPT
service iptables stop
SCRIPT
  # stop firewalld.service
  $systemctl_stop_firewalld = <<SCRIPT
systemctl stop firewalld.service
SCRIPT
  # common settings on all machines
  $etc_hosts = <<SCRIPT
cat <<END > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.0.4.6 mds01
10.0.4.7 mds02
10.0.4.8 oss01
10.0.4.9 oss02
10.0.4.20 centos6
10.0.4.30 centos7
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
  # provision puppet clients
  $epel6 = <<SCRIPT
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
SCRIPT
  $epel7 = <<SCRIPT
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
SCRIPT
  # lustre rhel repos
  $lustre_server_rhel = <<SCRIPT
yum clean all
cat <<'END' > /etc/yum.repos.d/lustre_server.repo
[lustre-server]
name=CentOS-$releasever - Lustre server
baseurl=https://downloads.hpdd.intel.com/public/lustre/lustre-2.8.0/el$releasever/server/
# https://jira.hpdd.intel.com/browse/LU-1354
gpgcheck=0
END
SCRIPT
  $zfs_epel6 = <<SCRIPT
# lustre-osd-zfs-2.8.0 (lustre-server) Requires: zfs-kmod
yum -y install http://archive.zfsonlinux.org/epel/zfs-release.el6.noarch.rpm
SCRIPT
  $zfs_epel7 = <<SCRIPT
# lustre-osd-zfs-2.8.0 (lustre-server) Requires: zfs-kmod
yum -y install http://archive.zfsonlinux.org/epel/zfs-release.el7.noarch.rpm
SCRIPT
  # CentOS vault (specific version of the kernel needed by lustre)
  $centos_vault = <<SCRIPT
RELEASE=$1
yum clean all
cat <<END > /etc/yum.repos.d/vault.repo
[vault]
name=CentOS-$RELEASE - vault
baseurl=http://vault.centos.org/$RELEASE/os/\\$basearch/
gpgcheck=1
[vault-updates]
name=CentOS-$RELEASE - vault-updates
baseurl=http://vault.centos.org/$RELEASE/updates/\\$basearch/
gpgcheck=1
END
SCRIPT
  $lustre_client_rhel = <<SCRIPT
yum clean all
cat <<'END' > /etc/yum.repos.d/lustre_client.repo
[lustre-client]
name=CentOS-$releasever - Lustre client
baseurl=https://downloads.hpdd.intel.com/public/lustre/lustre-2.8.0/el$releasever/client/
# https://jira.hpdd.intel.com/browse/LU-1354
gpgcheck=0
END
SCRIPT
  $lustre_client_189_wc1_rhel = <<SCRIPT
yum clean all
cat <<'END' > /etc/yum.repos.d/lustre_client.repo
[lustre-client]
name=CentOS-$releasever - Lustre client
baseurl=https://downloads.hpdd.intel.com/public/lustre/lustre-1.8.9-wc1/el$releasever/client/RPMS/
# https://jira.hpdd.intel.com/browse/LU-1354
gpgcheck=0
[lustre-client-source]
name=CentOS-$releasever - Lustre client-source
baseurl=https://downloads.hpdd.intel.com/public/lustre/lustre-1.8.9-wc1/el$releasever/client/SRPMS/
# https://jira.hpdd.intel.com/browse/LU-1354
gpgcheck=0
END
SCRIPT
  $lustre_client_local_rhel = <<SCRIPT
yum clean all
cat <<'END' > /etc/yum.repos.d/lustre_client_local.repo
[lustre-client-local]
name=CentOS-$releasever - Lustre client locally built RPMS
baseurl=file:///root/rpmbuild/RPMS
enabled=1
gpgcheck=0
END
SCRIPT
  # e2fsprogs
  # https://groups.google.com/forum/#!topic/lustre-discuss-list/U93Ja6Xkxfk
  $e2fsprogs_rhel = <<SCRIPT
yum clean all
cat <<'END' > /etc/yum.repos.d/e2fsprogs.repo
[e2fsprogs]
name=CentOS-$releasever - e2fsprogs
baseurl=https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el$releasever/
#baseurl=http://build.whamcloud.com/job/e2fsprogs-master/arch=$basearch%2Cdistro=el$releasever/lastSuccessfulBuild/artifact/_topdir/RPMS/
# https://groups.google.com/forum/#!topic/lustre-discuss-list/U93Ja6Xkxfk
gpgcheck=0
END
SCRIPT
  $etc_modprobe_d_lnet = <<SCRIPT
echo "options lnet networks=tcp0(eth1)" >> /etc/modprobe.d/lnet.conf
SCRIPT
  # lustre mounts
  $etc_fstab_lustre = <<SCRIPT
dev=$1
mnt=$2
options=$3
echo ${dev}, ${mnt}, ${options}
mkdir -p ${mnt}
cat <<END >> /etc/fstab
${dev}        ${mnt}        lustre  ${options}     0       0
END
SCRIPT
  # lustre kernel/firmware - install
  $lustre_kernel_install = <<SCRIPT
kernel_version=`yum list --showduplicates kernel | grep lustre-server | awk '{print $2}'`
kernel_firmware_version=`yum list --showduplicates kernel-firmware | grep lustre-server | awk '{print $2}'`
yum -y install --nogpgcheck --setopt=protected_multilib=false kernel-${kernel_version} kernel-firmware-${kernel_firmware_version} kernel-devel-${kernel_version} kernel-headers-${kernel_version}
yum clean all
SCRIPT
  # lustre kernel/firmware - install
  $kernel_version_lock = <<SCRIPT
yum versionlock add kernel
yum versionlock add kernel-firmware
yum versionlock add kernel-devel
yum versionlock add kernel-headers
SCRIPT
  # [Errno 14] problem making ssl connection
  $yum_problem_making_ssl_connection = <<SCRIPT
# [Errno 14] problem making ssl connection
yum -y update nss* ca-certificates pycurl
yum clean all
SCRIPT
  config.vm.define "mds01" do |mds01|
    mds01.vm.provision :shell, :inline => "hostname mds01", run: "always"
    mds01.vm.provision :shell, :inline => $etc_hosts
    mds01.vm.provision :shell, :inline => $yum_problem_making_ssl_connection
    mds01.vm.provision :shell, :inline => $epel6
    mds01.vm.provision :shell, :inline => $lustre_server_rhel
    mds01.vm.provision :shell, :inline => $e2fsprogs_rhel
    mds01.vm.provision :shell, :inline => $lustre_kernel_install
    mds01.vm.provision :shell, :inline => "yum -y install yum-plugin-versionlock"
    mds01.vm.provision :shell, :inline => $kernel_version_lock
    mds01.vm.provision :shell, :inline => "yum -y install lustre-osd-ldiskfs* lustre e2fsprogs* lustre-tests"
    mds01.vm.provision :shell, :inline => "yum versionlock lustre* e2fsprogs* libcom* libss libss-devel"
    mds01.vm.provision :shell, :inline => $etc_modprobe_d_lnet
    mds01.vm.provision :shell, :inline => "chkconfig lnet on"
    mds01.vm.provision :shell, :inline => "chkconfig lustre on"
    mds01.vm.provision :shell, :inline => "chkconfig iptables off"
    # configure lustre management server
    mds01.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --mgs --failnode=mds02@tcp0 /dev/sdb"
    mds01.vm.provision "shell" do |s|
      s.inline = $etc_fstab_lustre
      s.args   = ["/dev/sdb", "/lustre/mgt01", "defaults"]
    end
    # configure lustre metadata server
    mds01.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --mdt --index=0 --failnode=mds02@tcp0 --mgsnode=mds01@tcp0 --mgsnode=mds02@tcp0 /dev/sdc"
    mds01.vm.provision "shell" do |s|
      s.inline = $etc_fstab_lustre
      s.args   = ["/dev/sdc", "/lustre/mdt01", "defaults"]
    end
    # https://github.com/aidanns/vagrant-reload/issues/6
    #mds01.vm.provision :reload
    #mds01.vm.provision :shell, :inline => "reboot"  # this gives exit 1
    mds01.vm.provision :shell, :inline => $setenforce_0, run: "always"
    # start lustre management server
    #mds01.vm.provision :shell, :inline => "mount /lustre/mgt01", run: "always"
    # start lustre metadata server
    #mds01.vm.provision :shell, :inline => "mount /lustre/mdt01", run: "always"
  end
  config.vm.define "mds02" do |mds02|
    mds02.vm.provision :shell, :inline => "hostname mds02", run: "always"
    mds02.vm.provision :shell, :inline => $etc_hosts
    mds02.vm.provision :shell, :inline => $yum_problem_making_ssl_connection
    mds02.vm.provision :shell, :inline => $epel6
    mds02.vm.provision :shell, :inline => $lustre_server_rhel
    mds02.vm.provision :shell, :inline => $e2fsprogs_rhel
    mds02.vm.provision :shell, :inline => $lustre_kernel_install
    mds02.vm.provision :shell, :inline => "yum -y install yum-plugin-versionlock"
    mds02.vm.provision :shell, :inline => $kernel_version_lock
    mds02.vm.provision :shell, :inline => "yum -y install lustre-osd-ldiskfs* lustre e2fsprogs* lustre-tests"
    mds02.vm.provision :shell, :inline => "yum versionlock lustre* e2fsprogs* libcom* libss libss-devel"
    mds02.vm.provision :shell, :inline => $etc_modprobe_d_lnet
    mds02.vm.provision :shell, :inline => "chkconfig lnet on"
    mds02.vm.provision :shell, :inline => "chkconfig lustre on"
    mds02.vm.provision :shell, :inline => "chkconfig iptables off"
    # https://github.com/aidanns/vagrant-reload/issues/6
    #mds02.vm.provision :reload
    #mds02.vm.provision :shell, :inline => "reboot"  # this gives exit 1
    mds02.vm.provision :shell, :inline => $setenforce_0, run: "always"
  end
  config.vm.define "oss01" do |oss01|
    oss01.vm.provision :shell, :inline => "hostname oss01", run: "always"
    oss01.vm.provision :shell, :inline => $etc_hosts
    oss01.vm.provision :shell, :inline => $yum_problem_making_ssl_connection
    oss01.vm.provision :shell, :inline => $epel6
    oss01.vm.provision :shell, :inline => $lustre_server_rhel
    oss01.vm.provision :shell, :inline => $e2fsprogs_rhel
    oss01.vm.provision :shell, :inline => $lustre_kernel_install
    oss01.vm.provision :shell, :inline => "yum -y install yum-plugin-versionlock"
    oss01.vm.provision :shell, :inline => $kernel_version_lock
    oss01.vm.provision :shell, :inline => "yum -y install lustre-osd-ldiskfs* lustre e2fsprogs*"
    oss01.vm.provision :shell, :inline => "yum versionlock lustre* e2fsprogs* libcom* libss libss-devel"
    oss01.vm.provision :shell, :inline => $etc_modprobe_d_lnet
    oss01.vm.provision :shell, :inline => "chkconfig lnet on"
    oss01.vm.provision :shell, :inline => "chkconfig lustre on"
    oss01.vm.provision :shell, :inline => "chkconfig iptables off"
    # configure lustre object storage targets
    oss01.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --ost --index=0 --failnode=oss02@tcp0 --mgsnode=mds01@tcp0 --mgsnode=mds02@tcp0 /dev/sdb"
    oss01.vm.provision "shell" do |s|
      s.inline = $etc_fstab_lustre
      s.args   = ["/dev/sdb", "/lustre/ost01", "defaults"]
    end
    # # https://github.com/aidanns/vagrant-reload/issues/6
    #oss01.vm.provision :reload
    #oss01.vm.provision :shell, :inline => "reboot"  # this gives exit 1
    oss01.vm.provision :shell, :inline => $setenforce_0, run: "always"
    # start lustre object storage targets
    #oss01.vm.provision :shell, :inline => "mount /lustre/ost01", run: "always"
  end
  config.vm.define "oss02" do |oss02|
    oss02.vm.provision :shell, :inline => "hostname oss02", run: "always"
    oss02.vm.provision :shell, :inline => $etc_hosts
    oss02.vm.provision :shell, :inline => $yum_problem_making_ssl_connection
    oss02.vm.provision :shell, :inline => $epel6
    oss02.vm.provision :shell, :inline => $lustre_server_rhel
    oss02.vm.provision :shell, :inline => $e2fsprogs_rhel
    oss02.vm.provision :shell, :inline => $lustre_kernel_install
    oss02.vm.provision :shell, :inline => "yum -y install yum-plugin-versionlock"
    oss02.vm.provision :shell, :inline => $kernel_version_lock
    oss02.vm.provision :shell, :inline => "yum -y install lustre-osd-ldiskfs* lustre e2fsprogs*"
    oss02.vm.provision :shell, :inline => "yum versionlock lustre* e2fsprogs* libcom* libss libss-devel"
    oss02.vm.provision :shell, :inline => $etc_modprobe_d_lnet
    oss02.vm.provision :shell, :inline => "chkconfig lnet on"
    oss02.vm.provision :shell, :inline => "chkconfig lustre on"
    oss02.vm.provision :shell, :inline => "chkconfig iptables off"
    # configure lustre object storage targets
    oss02.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --ost --index=1 --failnode=oss01@tcp0 --mgsnode=mds01@tcp0 --mgsnode=mds02@tcp0 /dev/sdc"
    oss02.vm.provision "shell" do |s|
      s.inline = $etc_fstab_lustre
      s.args   = ["/dev/sdc", "/lustre/ost02", "defaults"]
    end
    # https://github.com/aidanns/vagrant-reload/issues/6
    #oss02.vm.provision :reload
    #oss02.vm.provision :shell, :inline => "reboot"  # this gives exit 1
    oss02.vm.provision :shell, :inline => $setenforce_0, run: "always"
    # start lustre object storage targets
    #oss02.vm.provision :shell, :inline => "mount /lustre/ost02", run: "always"
  end
  
  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  (0..8).each do |c_idx|
    config.vm.define "cl#{c_idx}" do |client|
      client.vm.provision :shell, :inline => "hostname cl#{c_idx}", run: "always"
      # client.vm.provision :shell, :inline => $etc_hosts, run: "always"
      client.vm.provision :shell, :inline => $etc_hosts
      # client.vm.provision :shell, :inline => $yum_problem_making_ssl_connection
      client.vm.provision :shell, :inline => $systemctl_stop_firewalld, run: "always"
      client.vm.provision :shell, :inline => $setenforce_0, run: "always"
      # client.vm.provision :shell, :inline => "source /xch/ldms/setup.sh", run: "always"
    end
  end

  config.vm.define "cl0" do |client|
    client.vm.provision :shell, :inline => "source /xch/start_control.sh", run: "always"
  end

  (1..8).each do |c_idx|
    config.vm.define "cl#{c_idx}" do |client|
      client.vm.provision :shell, :inline => "source /xch/start_compute.sh", run: "always"
    end
  end
  # ==============================================================================================================
end

# -*- mode: ruby -*-
# vi: set ft=ruby :


$IDE = "IDE"
cur_dir = File.dirname(File.expand_path(__FILE__))
load "%s/%s" % [cur_dir,"common_vars.rb"]

Vagrant.configure(2) do |config|
  ["mds01", "oss01", "oss02"].each do |name|
    config.vagrant.plugins = "vagrant_reboot_linux"
    config.vm.define name do |m|
#      m.vm.box = "centos/7"
#      m.vm.box_version = "2004.01"
#      m.vm.box_url = 'centos/7'
       m.vm.box = "cedadev/centos7"
       m.vm.box_version = "0.0.2"
      # installing lustre kernel removes virtualbox guest additions
      m.vm.synced_folder ".", "/vagrant", disabled: true
      m.vm.synced_folder "xch/scripts", "/xch/scripts", type: "rsync", rsync__exclude: ".git/"
    end
  end
  # mds01
  config.vm.define "mds01" do |mds01|
    mds01.vm.network "private_network", ip: "10.0.4.6"
    mds01.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
    end
    mds01.vm.provider "virtualbox" do |vb|
      if !File.exist?("%s/%s" % [cur_dir,"mgt01.vdi"])
        vb.customize ["createhd", "--filename", "mgt01.vdi", "--size", 1024, "--variant", "Fixed"]
        vb.customize ["modifyhd", "mgt01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", $IDE, "--port", 0, "--device", 1, "--type", "hdd", "--medium", "mgt01.vdi"]
      if !File.exist?("%s/%s" % [cur_dir,"mdt01.vdi"])
        vb.customize ["createhd", "--filename", "mdt01.vdi", "--size", 1024, "--variant", "Fixed"]
        vb.customize ["modifyhd", "mdt01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", $IDE, "--port", 1, "--device", 0, "--type", "hdd", "--medium", "mdt01.vdi"]
      vb.customize ['modifyvm', :id, '--natnet1', "10.0.46.0/24"]
    end
  end
  # oss01
  config.vm.define "oss01" do |oss01|
    oss01.vm.network "private_network", ip: "10.0.4.8"
    oss01.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
    end
    oss01.vm.provider "virtualbox" do |vb|
      if !File.exist?("ost01.vdi")
        vb.customize ["createhd", "--filename", "ost01.vdi", "--size", 8192, "--variant", "Fixed"]
        vb.customize ["modifyhd", "ost01.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", $IDE, "--port", 1, "--device", 0, "--type", "hdd", "--medium", "ost01.vdi"]
      vb.customize ['modifyvm', :id, '--natnet1', "10.0.48.0/24"]
    end
  end
  # oss02
  config.vm.define "oss02" do |oss02|
    oss02.vm.network "private_network", ip: "10.0.4.9"
    oss02.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
    end
    oss02.vm.provider "virtualbox" do |vb|
      if !File.exist?("ost02.vdi")
        vb.customize ["createhd", "--filename", "ost02.vdi", "--size", 8192, "--variant", "Fixed"]
        vb.customize ["modifyhd", "ost02.vdi", "--type", "shareable"]
      end
      vb.customize ["storageattach", :id, "--storagectl", $IDE, "--port", 1, "--device", 0, "--type", "hdd", "--medium", "ost02.vdi"]
      vb.customize ['modifyvm', :id, '--natnet1', "10.0.49.0/24"]
    end
  end



  ["mds01", "oss01", "oss02"].each do |name|
    config.vm.define name do |m|
      # Vagrant UID is 500 on all machines - no need to change it here
      #m.vm.provision :shell do |s|
      #  s.inline = $fix_vagrant_user
      #  s.reset = true
      #end
      # Make "slurm" user with same UID on all machines (may be not needed on Lustre servers)
      m.vm.provision :shell, name: "useradd slurm", :inline => "useradd -u 1001 slurm"
      m.vm.provision :shell, name: "hostname", :inline => "hostname #{name}", run: "always"
      m.vm.provision :shell, name: "etc_hosts", :inline => $etc_hosts
      m.vm.provision :shell, name: "yum_problem_making_ssl_connection", :inline => $yum_problem_making_ssl_connection
      m.vm.provision :shell, name: "install_prerequesites_server", :inline => $install_prerequesites_server
      # CHECK: epel may be needed only for ZFS
      m.vm.provision :shell, name: "epel7", :inline => $epel7
      m.vm.provision :shell, name: "create_repo_lustre_server", :inline => $create_repo_lustre_server
      m.vm.provision :shell, name: "create_repo_e2fsprogs", :inline => $create_repo_e2fsprogs
      m.vm.provision :shell, name: "install_lustre_server_kernel", :inline => $install_lustre_server_kernel
      m.vm.provision :shell, name: "install yum-plugin-versionlock", :inline => "yum -y install yum-plugin-versionlock"
      m.vm.provision :shell, name: "kernel_version_lock", :inline => $kernel_version_lock
      m.vm.provision :shell do |shell|
          shell.name = 'reboot'
          shell.privileged = true
          shell.inline = 'echo rebooting'
          shell.reboot = true
      end
      m.vm.provision :shell, name: "install e2fsprogs", :inline => "yum -y --nogpgcheck --disablerepo=* --enablerepo=e2fsprogs-wc install e2fsprogs"
      m.vm.provision :shell, name: "install lustre", :inline => "yum -y --nogpgcheck --enablerepo=lustre-server install kmod-lustre kmod-lustre-osd-ldiskfs lustre-osd-ldiskfs-mount lustre lustre-resource-agents"
      m.vm.provision :shell, name: "versionlock lustre", :inline => "yum versionlock lustre* e2fsprogs* libcom* libss libss-devel"
      m.vm.provision :shell, name: "etc_modprobe_d_lnet", :inline => $etc_modprobe_d_lnet
      m.vm.provision :shell do |shell|
          shell.privileged = true
          shell.inline = 'echo rebooting'
          shell.reboot = true
      end
#      m.vm.provision :shell, name: "chkconfig lnet on", :inline => "chkconfig lnet on"
      m.vm.provision :shell, name: "systemctl_stop_firewalld", :inline => $systemctl_stop_firewalld, run: "always"
      m.vm.provision :shell, name: "setenforce_0", :inline => $setenforce_0, run: "always"
      m.vm.provision :shell, name: "modprobe lnet", :inline => "modprobe lnet", run: "always"
      m.vm.provision :shell, name: "lctl network up", :inline => "lctl network up", run: "always"
#      m.vm.provision :shell, name: "chkconfig lustre on", :inline => "chkconfig lustre on"
#      m.vm.provision :shell, name: "", :inline => "chkconfig iptables off"
    end
  end

  config.vm.define "mds01" do |mds01|
    mds01.vm.provision :shell, name: "hostname", :inline => "hostname mds01", run: "always"
    # configure lustre management server
    mds01.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --mgs --mgsnode=mds01@tcp0 /dev/sdb"
    mds01.vm.provision :shell, name: "mkdir -p /lustre/mgt01", :inline => "mkdir -p /lustre/mgt01"
    mds01.vm.provision :shell, name: "mount /lustre/mgt01", :inline => "mount -t lustre /dev/sdb /lustre/mgt01", run: "always"
    # configure lustre metadata server
    mds01.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --mdt --index=0 --mgsnode=mds01@tcp0 /dev/sdc"
    mds01.vm.provision :shell, name: "mkdir -p /lustre/mdt01", :inline => "mkdir -p /lustre/mdt01"
    mds01.vm.provision :shell, name: "mount /lustre/mdt01", :inline => "mount -t lustre /dev/sdc /lustre/mdt01", run: "always"
  end

  config.vm.define "oss01" do |oss01|
    oss01.vm.provision :shell, name: "hostname", :inline => "hostname oss01", run: "always"
    # configure lustre object storage targets
    oss01.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --ost --index=0 --mgsnode=mds01@tcp0 /dev/sdb"
    oss01.vm.provision :shell, name: "mkdir -p /lustre/oss01", :inline => "mkdir -p /lustre/oss01"
    oss01.vm.provision :shell, name: "mount /lustre/oss01", :inline => "mount -t lustre /dev/sdb /lustre/oss01", run: "always"
  end

  config.vm.define "oss02" do |oss02|
    oss02.vm.provision :shell, name: "hostname", :inline => "hostname oss02", run: "always"
    # configure lustre object storage targets
    oss02.vm.provision :shell, :inline => "mkfs.lustre --backfstype=ldiskfs --reformat --fsname=testfs --ost --index=1 --mgsnode=mds01@tcp0 /dev/sdb"
    oss02.vm.provision :shell, name: "mkdir -p /lustre/oss02", :inline => "mkdir -p /lustre/oss02"
    oss02.vm.provision :shell, name: "mount /lustre/oss02", :inline => "mount -t lustre /dev/sdb /lustre/oss02", run: "always"
  end


  # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # client client
  (0..8).each do |c_idx|
    config.vm.define "cl#{c_idx}" do |client|
      client.vm.provider "virtualbox" do |vb|
        # vb.customize ['modifyvm', :id, '--macaddress1', '08002700005#{c_idx}']
	      vb.customize ['modifyvm', :id, '--natnet1', "10.0.5#{c_idx}.0/24"]
      end
      client.vm.box = "%s/%s" % [cur_dir,"basenode"]
      client.vm.box_url = "%s/basenode/%s" % [cur_dir,"basenode"]
      client.vm.synced_folder "xch", "/xch"

      client.vm.synced_folder ".", "/vagrant", disabled: true

      client.vm.network "private_network", ip: "10.0.4.5#{c_idx}"
      client.vm.provider "virtualbox" do |v|
        v.memory = c_idx == 0 ? 4096 : 1024
        v.cpus = 1
      end
      client.vm.provision :shell, :inline => "hostname cl#{c_idx}", run: "always"
      client.vm.provision :shell, :inline => $etc_hosts
#      client.vm.synced_folder ".", "/vagrant", disabled: true
#      client.vm.provision :shell, :inline => $yum_problem_making_ssl_connection
      client.vm.provision :shell, :inline => $systemctl_stop_firewalld, run: "always"
      client.vm.provision :shell, :inline => $setenforce_0, run: "always"
      client.vm.provision :shell, name: "etc_modprobe_d_lnet", :inline => $etc_modprobe_d_lnet
      client.vm.provision :shell, name: "modprobe lnet", :inline => "modprobe lnet", run: "always"
      client.vm.provision :shell, name: "lctl network up", :inline => "lctl network up", run: "always"
      client.vm.provision :shell, name: "mount /lustre", :inline => "mount -t lustre -o defaults,_netdev,user_xattr mds01@tcp0:/testfs /lustre", run: "always"
      client.vm.provision :shell, name: "set envvars",
        inline: "cp /xch/config/envvars.sh /etc/profile.d/zzz_99_envvars.sh && /xch/config/envvars.sh"
    end
  end

  config.vm.define "cl0" do |client|
    client.vm.provision :shell, :inline => "pip3 install -r /xch/py-sim-serv/requirements.txt"
    client.vm.provision :shell, name: "mkdir -p /LDMS_data/SOS/sos1/", :inline => "mkdir -p /LDMS_data/SOS/sos1/"
    client.vm.provision :shell, name: "make sevi", :inline => "cd /xch/sevi && make"
    client.vm.provision :shell, :path => "xch/scripts/start_control.sh", run: "always"
  end

  (1..8).each do |c_idx|
    config.vm.define "cl#{c_idx}" do |client|
      client.vm.provision :shell, :path => "xch/scripts/start_compute.sh", run: "always"
    end
  end
  # ==============================================================================================================
end

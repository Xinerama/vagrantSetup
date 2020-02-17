# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
CONTROLLER = ENV.fetch('CONTROLLER', 'IDE')
file_to_disk1 = 'virtualDisk1.vdi'

Vagrant.configure("2") do |config|
  # The below two options allow "vagrant -Y ssh" which is a secure way to run graphical applications
  config.ssh.forward_agent = true # This is where the magic happens. Open your favorite graphical app by enabling this option.
  config.ssh.forward_x11 = true
 
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--cpus", 2]
  end
  
  # OMG this is so important
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  # The 'false' at the end prevents Vagrant from prompting for a password
  # The 'false' at the end prevents Vagrant from prompting for a password
  config.vm.synced_folder ".", "/vagrant", type: "nfs" #, nfs_export: false

    #VM1: Server 
    config.vm.define "server" do |config|
    config.vm.box = "centos/8"
    config.vm.hostname = "server"
    config.vm.network :private_network, ip: "192.168.11.11"
    config.vm.box_check_update = false
    config.vm.provision :shell, path: "bootstrapServer.sh"
    config.ssh.insert_key = false
 #config.vm.provider :virtualbox do |vb|
 #   vb.customize ["modifyvm", :id, "--memory", 2048]
 #   vb.customize ["modifyvm", :id, "--cpus", 2]
 #end
     end

     #VM2: Node1
     config.vm.define "client" do |config|
     config.vm.box = "centos/8"
     config.vm.hostname = "client"
     config.vm.network :private_network, ip: "192.168.11.12"
     config.vm.box_check_update = false
     config.ssh.insert_key = false
     config.vm.provision :shell, path: "bootstrapClient.sh"
     config.vm.provider :virtualbox do |vb|
       vb.memory = "2048"
       unless File.exist?(file_to_disk1)
          vb.customize ['createhd', '--filename', file_to_disk1, '--size', 7 * 1024]
       end
          vb.customize ['storageattach', :id, '--storagectl', CONTROLLER, '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk1]
       end
     end
end


#VM3: Node2
 #config.vm.define "node2" do |node2|
 #node2.vm.box = "centos/8"
 #node2.vm.hostname = "Node2"
 #node2.vm.network :private_network, ip: "192.168.11.13"
 #node2.vm.box_check_update = false
 #node2.ssh.insert_key = false
 #config.vm.provider :virtualbox do |v|
#   v.customize ["modifyvm", :id, "--memory", 2048]
#   v.customize ["modifyvm", :id, "--cpus", 2]
# end
#end

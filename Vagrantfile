require 'yaml'
networks = YAML.load_file('network.yaml')

Vagrant.configure("2") do |config|
  config.vm.define "proxy" do |proxy|
    proxy.vm.box = "ubuntu/bionic64"
    proxy.vm.network "public_network", ip: "192.168.87.250"
    #proxy.vm.network "public_network", ip: "192.168.87.250", bridge: networks["network_bridge"]
    proxy.vm.provider "virtualbox" do |v|
      v.gui = false
      v.customize ['modifyvm', :id, '--memory', 512]
      v.customize ["modifyvm", :id, "--cpus", 1]
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
      v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
      v.customize ["modifyvm", :id, "--accelerate3d", "on"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
    proxy.vm.provision "shell" do |s|
      s.inline = "/bin/bash /vagrant/proxy/configure-proxy-server.sh"
      s.args = ""
    end
  end
  config.vm.define "pxe" do |pxe|
    pxe.vm.box = "ubuntu/bionic64"
    pxe.vm.network "public_network", ip: "192.168.87.254"
    #pxe.vm.network "public_network", ip: "192.168.87.254", bridge: networks["network_bridge"]
    #pxe.ssh.username = "vagrant"
    #pxe.ssh.password = "vagrant"
    #pxe.ssh.insert_key = true
    #pxe.ssh.pty = false
    pxe.vm.provider "virtualbox" do |v|
      v.gui = false
      v.customize ['modifyvm', :id, '--memory', 512]
      v.customize ["modifyvm", :id, "--cpus", 1]
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
      v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
      v.customize ["modifyvm", :id, "--accelerate3d", "on"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
    pxe.vm.provision "shell" do |s|
      s.inline = "echo $1; PROXY=$1 PXE=$2 /bin/bash /vagrant/pxe_files/configure-pxe-server.sh"
      s.args = "#{ENV['PROXY']} #{ENV['PXE']}"
    end
  end
end

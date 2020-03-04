
export PROXY := "192.168.87.250"
export PXE := "192.168.87.254"

removeboxes:
	@vagrant box remove ubuntu/bionic64

proxycache:
	@vagrant up proxy --provision

proxycacheSSH:
	@vagrant ssh proxy -c "touch /tmp/testing; tail -f /tmp/testing"

proxycachehalt:
	@vagrant halt proxy

box:
	@PROXY="$(PROXY)" sed "s|PROXY|$(PROXY):3142|g" http/preseed.cfg.orig > http/preseed.cfg
	@packer build -on-error=abort -force ubuntu-18.04.json

ubuntutest:
	@vagrant box add ubuntu16.04 ./builds/ubuntu-16.04-amd64-virtualbox.box --force
	@PROXY=$(PROXY) AWM=false DESKTOP=true vagrant up ubuntutest --provision

pxe:
	@PXE=$(PXE) PROXY=$(PROXY) vagrant up pxe --provision

pxeSSH: 
	@vagrant ssh pxe -c "touch /tmp/testing; tail -f /tmp/testing"

pxehalt: 
	@vagrant halt pxe

develop:
	curl https://raw.githubusercontent.com/UKHomeOffice/development_environment/develop/ansible/install.sh | GIT_REF=develop bash

clean:
	@vagrant destroy -f
	@rm -rf packer_cache

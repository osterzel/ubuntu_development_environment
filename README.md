# Generic Secure Development Environment

These ansible scripts are free to use and follow where possible best practice guidence from the security community. Please feel free to fork this repository for your own needs and also submit pull requests to enhance or harden where approptiate.

All modules included here should work as a minimum under xfce4 with either an Ubuntu or RedHat/CentOS base image. For Ubuntu the compatability checks start at 16.04 where as for RedHat/CentOS it also supports 6.7 along with 7 and above however, continuing support for 6.7 is not required so long as the module checks to only install on OS's of a higher version.

# FAQ

Some questions answere [here](./FAQ.md)


## Usage

### Setting up build environment

To create an environment that new computers can be PXE booted from a PXE boot server and a proxy server (to speed up subsequent builds) are required. These are started as follows:


During the startup it will ask which network interface to create a bridge on to this should be the device that you will plug the machines to build into

```
make proxycache
make pxe
```

Be aware that once the PXE server is up, it runs a DHCP service that may well assign your bridged interface an IP address and default route that it then tries (and fails) to use to connect to the internet. This will cause the builds to fail. To resolve this issue, either set the interface to only be used for IP address within its range or hard set the interface to use the IP address that it has been assigned, but delete the IP of the default gateway.

### Destroying the build environment

To destroy the build environment run the following:

```
make pxeclean
make proxyclean
```

#### Vagrantfile

The Vagrantfile has two lines commented out for setting the proxy and pxe public networks which includes the assignment of a network bridge similar to the following:

```
proxy.vm.network "public_network", ip: "ip_value", bridge: networks["network_bridge_value"]
```

These lines have been added to provide the option of running the vagrant up commands of both the pxe and proxy servers to run without human intervention of entering which network bridge to use. These lines are currently commented out to prevent any interference with existing users. However, if uncommented and used instead of the existing vm.network lines, then the network bridge value should be placed into a yaml file similar to the following:

```
network_bridge: 'network_bridge_value'
```

and the Vagrantfile will need to specify the location of the yaml file for it to read:

```
networks = YAML.load_file('location/network.yaml')

```

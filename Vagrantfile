# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box = "ubuntu/trusty64"
  config.omnibus.chef_version = "12.3.0"

  # config.vm.network "forwarded_port", guest: 3000, host: 4000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # config.vm.synced_folder ".", "/vagrant", nfs: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.synced_folder ".", "/home/vagrant/flashcards"

  config.vm.network :forwarded_port, guest: 3000, host: 1234

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "chef_solo" do |chef|
    # chef.cookbooks_path = ["chef/site-cookbooks", "chef/berks-cookbooks"]
    # chef.data_bags_path = "chef/data_bags"
    # chef.roles_path = "chef/roles"
    # chef.nodes_path = "chef/nodes"

    # chef.add_role "rails-app"

    #chef.add_recipe "yum"
    #chef.add_recipe "poise-python"
    chef.cookbooks_path = ["site-cookbooks", "cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "vim"

    chef.add_recipe "nodejs"

    chef.add_recipe "postgresql"
    chef.add_recipe "postgresql::server"

    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::system"

    chef.add_recipe "bootstrap-app"

    chef.json = {
      postgresql: {
        pg_hba: [
          {
            "type": "local",     "db": "all",       "user": "postgres",
            "addr": nil,         "method": "trust"
          },
          {
            "type": "local",     "db": "all",       "user": "all",
            "addr": nil,         "method": "md5"
          },
          {
            "type": "host",      "db": "all",       "user": "all",
            "method": "md5",     "addr": "127.0.0.1/32",
          },
          {
            "type": "host",      "db": "all",       "method": "md5",
            "user": "all",       "addr": "::1/128"
          },
          {
            "type": "local",     "db": "all",       "method": "trust",
            "user": "vagrant",   "addr": nil
          },
          {
            "type": "host",      "db": "all",       "method": "md5",
            "user": "all",       "addr": "192.168.248.1/24"
          }
        ],
        password: {
          postgres: "1234"
        }
      },
      rbenv: {
        rubies: ["2.3.1"],
        global: "2.3.1",
        gems: { "2.3.1": [{"name": "bundler"}]}
      }
    }
  end
end

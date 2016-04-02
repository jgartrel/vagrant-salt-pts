# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "geerlingguy/centos7"
  config.vm.hostname = "vagrant-bench"
  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion.yml"
    salt.run_highstate = true
    salt.colorize = true
    salt.log_level = 'info'
  end

end

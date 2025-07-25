# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"  # 22.04 LTS 最新官方版
  config.vm.box_version = "20230717.0.0"

  config.vm.provider :virtualbox do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "vagrant-ubuntu-jammy"
  end

  # 端口转发（示例）
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 9200, host: 9201

  # 共享文件夹
  config.vm.synced_folder ".", "/vagrant"

  # Provision 脚本
  config.vm.provision "shell", path: "scripts/bootstrap.sh", privileged: false

  # 内置触发器，启动后执行脚本
  config.trigger.after :up do |trigger|
    trigger.name = "Run up.sh after vagrant up"
    trigger.run_remote = { inline: "bash /vagrant/scripts/up.sh" }
  end
end

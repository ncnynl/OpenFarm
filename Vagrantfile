# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # 新版 Ubuntu
  config.vm.box = "ubuntu/24.04"

  # 使用 2GB 内存
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.name = "vagrant-ubuntu-2404"
  end

  # 端口映射
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 9200, host: 9201

  # 使用共享目录
  config.vm.synced_folder ".", "/vagrant"

  # 使用 shell 脚本进行初始化
  config.vm.provision "shell", path: "scripts/bootstrap.sh", privileged: false

  # 触发器写法已变，改用新版 triggers
  config.trigger.after :up do |trigger|
    trigger.name = "Run up.sh after vagrant up"
    trigger.run_remote = { inline: "bash /vagrant/scripts/up.sh" }
  end
end

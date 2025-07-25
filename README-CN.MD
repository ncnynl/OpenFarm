5. README.md

# Vagrant Ubuntu 22.04 开发环境

## 环境说明

- Ubuntu 22.04 (Jammy Jellyfish)
- Ruby 3.2.2 (通过 RVM)
- Elasticsearch 7.17.13
- MongoDB 5.0
- Node.js 20.x

## 使用步骤

1. 克隆项目
   git clone <your-repo-url>
   cd <your-project>

2. 启动虚拟机
vagrant up

3. 进入虚拟机
vagrant ssh

代码目录已挂载到 /vagrant

Rails 服务默认监听 3000 端口，宿主机可通过 http://localhost:3000 访问

# 备注
如果需要修改软件版本，请调整 scripts/versions.env

# 重新执行配置脚本：
vagrant provision

# 若虚拟机损坏，重新创建：
vagrant destroy -f
vagrant up

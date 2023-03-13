#!/bin/bash

#解决甲骨文服务器DD linux系统后，sudo service networking restart 或 sudo /etc/init.d/networking restart 重启网卡命令失效，重启网卡会导致SSH失联的问题。

# 获取网卡名
INTERFACE_NAME=$(ip link | awk -F ': ' '$0 !~ "lo|vir|wl|^[^0-9]"{print $2}')

# 输出网卡名
echo "本机网卡名为: ${INTERFACE_NAME}"

# 检查是否已经有对应的网卡自启动配置
if grep -q "auto ${INTERFACE_NAME}" /etc/network/interfaces; then
    echo "/etc/network/interfaces中已有: auto ${INTERFACE_NAME}."
else
    # 将自启动配置写入文件
    echo "auto ${INTERFACE_NAME}" | sudo tee -a /etc/network/interfaces > /dev/null
    echo "已将 auto ${INTERFACE_NAME} 添加进/etc/network/interfaces."
fi

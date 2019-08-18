#! /bin/bash
# 设置 socks 代理
networksetup -setsocksfirewallproxy "Wi-fi" 127.0.0.1 1086
# 显示 工作 状态
echo "socks proxy status:"
networksetup -getsocksfirewallproxy "Wi-Fi"
# 设置不走代理的 国内 ip 列表
curl -L http://www.ipdeny.com/ipblocks/data/countries/cn.zone |xargs networksetup -setproxybypassdomains "Wi-Fi"  127.0.0.1 localhost
echo "set cn pass done!"

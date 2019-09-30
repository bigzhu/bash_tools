#! /bin/bash
# 设置 socks 代理
networksetup -setsocksfirewallproxy "Wi-fi" 127.0.0.1 1086
# 显示 工作 状态
echo "socks proxy status:"
networksetup -getsocksfirewallproxy "Wi-Fi"
# 设置不走代理的 国内 ip 列表
#curl -L http://www.ipdeny.com/ipblocks/data/countries/cn.zone |xargs networksetup -setproxybypassdomains "Wi-Fi"  127.0.0.1 localhost
#curl -L https://raw.githubusercontent.com/HMBSbige/Text_Translation/master/chndomains.txt |xargs networksetup -setproxybypassdomains "Wi-Fi"  127.0.0.1 localhost
#curl -L https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt |xargs networksetup -setproxybypassdomains "Wi-Fi"  127.0.0.1 localhost
# curl -L https://raw.githubusercontent.com/ym/chnroutes2/master/chnroutes.txt |xargs networksetup -setproxybypassdomains "Wi-Fi"  127.0.0.1 localhost

# update: wget https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt
# get shell path
shell_path=$(cd `dirname $0`; pwd)
echo $shell_path
cat $shell_path/china_ip_list.txt |xargs -n99999 networksetup -setproxybypassdomains "Wi-Fi" 
echo "set cn bypass done!"

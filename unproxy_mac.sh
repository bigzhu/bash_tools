#! /bin/bash
networksetup -setsocksfirewallproxystate "Wi-Fi" off
# 显示 工作 状态
echo "socks proxy status:"
networksetup -getsocksfirewallproxy "Wi-Fi"

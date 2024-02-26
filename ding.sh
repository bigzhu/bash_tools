#!/usr/bin/env bash
# 钉钉的自动打卡
#
export PATH=$PATH:/home/bigzhu/Android/Sdk/platform-tools/
function rand() {
	min=$1
	max=$(($2 - $min + 1))
	num=$(date +%s%N)
	echo $(($num % $max + $min))
}

# 唤醒
adb -s FA69T0307042 shell input keyevent 26
adb -s FA69T0307042 shell input swipe 300 1700 300 500
adb -s FA69T0307042 shell input text z129854 && adb -s FA69T0307042 shell input keyevent 66

adb -s FA69T0307042 shell am start -n com.alibaba.android.rimet/com.alibaba.android.rimet.biz.LaunchHomeActivity
rnd=$(rand 10 20)
sleep "${rnd}s"
adb -s FA69T0307042 shell input tap 579 1722
rnd=$(rand 10 20)
sleep "${rnd}s"
adb -s FA69T0307042 shell input tap 330 1014
rnd=$(rand 10 20)
sleep "${rnd}s"
adb -s FA69T0307042 shell input tap 507 1133
sleep "10s"
adb -s FA69T0307042 shell am force-stop com.alibaba.android.rimet
sleep "10s"
adb -s FA69T0307042 shell input keyevent 26

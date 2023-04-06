#!/usr/bin/env bash
# 钉钉的自动打卡
#
function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}

rnd=$(rand 10 20)

adb shell am start -n com.alibaba.android.rimet/com.alibaba.android.rimet.biz.LaunchHomeActivity
rnd=$(rand 10 20)
sleep "${rnd}s"
adb shell input tap 579 1722
rnd=$(rand 10 20)
sleep "${rnd}s"
adb shell input tap 330 1014
rnd=$(rand 10 20)
sleep "${rnd}s"
adb shell input tap 507 1133
rnd=$(rand 10 20)
sleep "${rnd}s"
adb shell  am force-stop com.alibaba.android.rimet
rnd=$(rand 10 20)
sleep "${rnd}s"
adb shell input keyevent 26

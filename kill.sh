#! /bin/bash
killBz(){
    process_name=$1
    #pid=$(ps -aux | grep "$1" | grep -v grep | grep -v kill.sh| awk '{print $2}'|head -1)
    #mac 下的 ps 没有参数 aux, 改为 ef
    #vim 的要剔除
    pid=$(ps -ef | grep $process_name | grep -v grep | grep -v kill.sh| grep -v vim| awk '{print $2}'|head -1)
    if [[ -n $pid ]]; then
        echo "kill old $process_name pid=$pid"
        kill $pid
    else
        echo "$process_name Does not exist"
    fi
}
if [ $# -eq 0 ]
then
    :
else
    killBz $1   
fi

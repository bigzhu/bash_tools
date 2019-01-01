# bash_tools
一些封装好现成可用的 bash 脚本

## install

运行 

```
./install.sh
```

确定 `/usr/local/bin/` 在环境变量 `$PATH` 中
就可以在任意目录使用

## 脚本介绍
### install.sh
把当前目录的 *.sh 文件, 链接到 `/usr/local/bin/`

也是用来来安装本项目的脚本, 先执行.

### kill.sh

方便的杀进程, 直接: `kill.sh bigzhu.py` 即可.

#### 常规方式:

```bash
ps -ef|grep bigzhu.py
kill 33843784738
```
麻烦不说还容易出错.

#### killall 

killall 很蠢, 类似 python 或者 java 启动的进程就没法 kill

### pull.sh

60s 定时 git pull 一次, 简单粗暴.


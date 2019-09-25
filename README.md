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

如果链接已经存在, 添加 `-f` 来覆盖链接

```
./install.sh -f
```

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

### git_origin

修改 git 的 url 地址, github 最近不是开放私人仓库了么, 好多项目要修改

```bash
git_origin.sh git@github.com:bigzhu/english_buoy_go.git
```

来完成修改

注意, 直接指定为 master 了

### version.sh

自动增加 git tags 的 version.sh, 用于发布 golang 的项目版本

### mac_proxy.sh

mac 作为历史上最蠢的操作系统, 重启后设置的全局代理参数就这么默认消失了.

这里设置默认全局走 1086 proxy, 127.0.0.1 localhost 以及国内 ip 段除外

### img.sh
压缩图片到指定目录, 并复制 markdown 格式的图片地址到剪贴板中

根据需要自行修改 `blog_img_path` 和 `url_path` 为自己需要的路径

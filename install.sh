#! /bin/bash

if [ $1 ] && [ $1 = "-f" ] ;then
    echo "force repalce link!";
    sudo ln -sf ${PWD}/*.sh  /usr/local/bin/
else
    echo "fuck";
    sudo ln -s ${PWD}/*.sh  /usr/local/bin/
fi


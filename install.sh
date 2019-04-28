#! /bin/bash

force=false

help(){
  echo "Usage: install.sh file_name [-f]"

  echo ""
  echo "Flags:"
  echo "  -f"
  echo "    force install if File exists(will repalce!)"
  echo "  -h"
  echo "    show help info"
  echo ""
  echo "Example:"
  echo "  one file:"
  echo "    install.sh ssh.py"
  echo "  multiple file:"
  echo "    install.sh *.py"
  echo  " force install:"
  echo "    install.sh *.py -f"
}


# check is need force install
for param in "$@"
do
  if [ $param = "-f" ]; then
    #echo "$param force is true"
    force=true;
  elif [ $param = "-h" ]; then
    help;
  fi
done


if [ $1 ];then
  for param in "$@"
  do
    if [ $param != "-f" ] && [ $param != "-h" ]; then
      if [ $force = true ];then
        echo "force install $param to /usr/local/bin/";
        sudo ln -sf ${PWD}/$param  /usr/local/bin/
      else
        echo "install $param to /usr/local/bin/";
        sudo ln -s ${PWD}/$param  /usr/local/bin/
      fi
    fi
  done
else
  help;
fi

#!/bin/bash
bashrc=$HOME/.bashrc

usage() {
  /bin/cat << EOT
usage: setup465.sh [ 1 | 2 | 3 | 4 | 5 | 6 ]
   ex: "\$ setup465.sh 4" configures environment for lab 4
EOT
}

# check to see if installer has been run
egrep "COMP465LAB" $bashrc 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  # not found
  echo "it looks like your COMP 465 environment isn't setup yet. please run install.sh first"
  exit 0
fi

# ensure that we've been called with the right arguments
if [ $# -ne 1 ]; then
  usage
  exit 1
fi

case $1 in
  1)
    lab=lab1
    ;;
  2)
    lab=lab2
    ;;
  3)
    lab=lab3
    ;;
  4)
    lab=lab4
    ;;
  5)
    lab=lab5
    ;;
  6)
    lab=lab6
    ;;
  *)
    echo "error: lab number not legal: $1"
    usage
    exit 1
    ;;
esac

# make a backup copy of .bashrc
/bin/cp $bashrc $bashrc.backup

# update with new lab number
/bin/sed -e "s/COMP465LAB=lab[1-6]/COMP465LAB=$lab/" < $bashrc > /tmp/setup465.$$
/bin/mv /tmp/setup465.$$ $bashrc

# remind user to refresh environment settings
echo "setup complete. you need to update your environment with the new settings. pick one:"
echo "    1. log out / log back in again (or start a new terminal)"
echo "    2. type the command '. ~/.bashrc' to reload without logging out"
exit 0

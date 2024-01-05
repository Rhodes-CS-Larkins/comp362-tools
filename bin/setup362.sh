#!/bin/bash
if [ "$SHELL" = "/bin/bash" ]; then
  bashrc=$HOME/.bashrc
else
  bashrc=$HOME/.zshrc
fi

usage() {
  /bin/cat << EOT
usage: setup362.sh [ 1 | 2 | 3 | 4 | 5 | 6 ]
   ex: "\$ setup362.sh 4" configures environment for lab 4
EOT
}

# check to see if installer has been run
egrep "COMP362LAB" $bashrc 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  # not found
  echo "it looks like your COMP 362 environment isn't setup yet. please run install.sh first"
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
sed -e "s/COMP362LAB=lab[1-6]/COMP362LAB=$lab/" < $bashrc > /tmp/setup362.$$
/bin/mv /tmp/setup362.$$ $bashrc

# remind user to refresh environment settings
echo "setup complete. you need to update your environment with the new settings. pick one:"
echo "    1. log out / log back in again (or start a new terminal)"
if [ "$SHELL" = "/bin/bash" ]; then
  echo "    2. type the command '. ~/.bashrc' to reload without logging out"
else
  echo "    2. type the command '. ~/.zshrc' to reload without logging out"
fi
exit 0

#!/bin/bash

curdir=`pwd`
toolroot=`echo $curdir | sed -e "s!/bin!!"`
bashrc=$HOME/.bashrc

# check to see if installer has run before
/bin/egrep "COMP465TOOLS" $bashrc 2>&1 > /dev/null
if [ $? -eq 0 ]; then
  # found
  echo "removing existing compiler environment setup"
  sed -e "/added by compiler tools/,+7d" < $bashrc > /tmp/install.$$
  mv /tmp/install.$$ $bashrc
fi

cat << EOT >> $bashrc

# added by compiler tools installer
COMP465TOOLS="$toolroot"
COMP465LAB="lab1"
PATH=\$PATH:\$COMP465TOOLS/bin
CLASSPATH=.:..:\$COMP465TOOLS/../\$COMP465LAB:\$COMP465TOOLS/classes/jlex.jar:\$COMP465TOOLS/classes/java_cup.jar:\$COMP465TOOLS/classes/\$COMP465LAB.jar
export COMP465TOOLS COMP465LAB PATH CLASSPATH
# end compilers additions
EOT

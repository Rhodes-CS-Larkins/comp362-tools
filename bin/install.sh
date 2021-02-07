#!/bin/bash

curdir=`pwd`
toolroot=`echo $curdir | sed -e "s!/bin!!"`
if [ "$SHELL" = "/bin/bash" ]; then
  bashrc=$HOME/.bashrc
else
  bashrc=$HOME/.zshrc
fi


# make backup
if [ -f $bashrc ]; then
  /bin/cp $bashrc $bashrc.backup
fi

# check to see if installer has run before
egrep "COMP465TOOLS" $bashrc 2>&1 > /dev/null
if [ $? -eq 0 ]; then
  # found - discard earlier info
  echo "removing existing compiler environment setup"
  /bin/sed -e "/added by compiler tools/,+7d" < $bashrc > /tmp/install.$$
  /bin/mv /tmp/install.$$ $bashrc
fi

# update .bashrc with correct environment info
/bin/cat << EOT >> $bashrc

# added by compiler tools installer
COMP465TOOLS="$toolroot"
COMP465LAB=lab1
PATH=\$PATH:\$COMP465TOOLS/bin
CLASSPATH=.:..:\$COMP465TOOLS/../comp465-\$COMP465LAB:\$COMP465TOOLS/classes/jlex.jar:\$COMP465TOOLS/classes/java_cup.jar:\$COMP465TOOLS/classes/\$COMP465LAB.jar
export COMP465TOOLS COMP465LAB PATH CLASSPATH
# end compilers additions
EOT

echo "installation complete."

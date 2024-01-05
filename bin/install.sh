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
  cp $bashrc $bashrc.backup
fi

# check to see if installer has run before
egrep "COMP362TOOLS" $bashrc 2>&1 > /dev/null
if [ $? -eq 0 ]; then
  # found - discard earlier info
  echo "removing existing compiler environment setup"
  sed -e "/added by compiler tools/,+7d" < $bashrc > /tmp/install.$$
  mv /tmp/install.$$ $bashrc
fi

# update .bashrc with correct environment info
cat << EOT >> $bashrc

# added by compiler tools installer
COMP362TOOLS="$toolroot"
COMP362LAB=lab1
PATH=\$PATH:\$COMP362TOOLS/bin
CLASSPATH=.:..:\$COMP362TOOLS/../comp362-\$COMP362LAB:\$COMP362TOOLS/classes/jlex.jar:\$COMP362TOOLS/classes/java_cup.jar:\$COMP362TOOLS/classes/\$COMP362LAB.jar
export COMP362TOOLS COMP362LAB PATH CLASSPATH
# end compilers additions
EOT

echo "installation complete."

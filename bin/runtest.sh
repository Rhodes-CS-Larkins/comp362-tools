#!/bin/bash

# environment
toolroot=$COMP465TOOLS
labroot=$toolroot/../comp465-$COMP465LAB
redir=1
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

case $COMP465LAB in
  lab1)
    mainclass="Parse.Main"
    ;;
  lab2)
    mainclass="Parse.Main"
    ;;
  lab3)
    mainclass="Semant.Main"
    ;;
  lab4)
    mainclass="Semant.Main"
    ;;
  lab5)
    mainclass="Translate.Main"
    ;;
  lab6)
    mainclass="Main.Main"
    redir=0
    ;;
  *)
    echo "it looks like your environment isn't setup correctly, run install.sh and setup465.sh to reset it."
    exit 1
    ;;
esac


cd $labroot
echo "running regression tests for comp465-$COMP465LAB"

# check if reference output exists
if [ ! -d $labroot/output/ref ]; then
  echo "generating reference compiler output"
  # make reference output directory
  /bin/mkdir -p $labroot/output/ref

  # generate reference output
  /usr/bin/make clean

  for i in {1..49}
  do
    echo -n "test$i.tig "
    if [ $redir -eq 1 ]; then
      java $mainclass $toolroot/testcases/test$i.tig > $labroot/output/ref/test$i.tig 2>&1
    else
      java $mainclass $toolroot/testcases/test$i.tig
      mv $toolroot/testcases/test$i.s $labroot/output/ref/test$i.tig
    fi
  done

  echo -n "merge.tig "
  if [ $redir -eq 1 ]; then
    java $mainclass $toolroot/testcases/merge.tig > $labroot/output/ref/merge.tig 2>&1
  else
    java $mainclass $toolroot/testcases/merge.tig
    mv $toolroot/testcases/merge.s $labroot/output/ref/merge.tig
  fi

  echo "queens.tig"
  if [ $redir -eq 1 ]; then
    java $mainclass $toolroot/testcases/queens.tig > $labroot/output/ref/queens.tig 2>&1
  else
    java $mainclass $toolroot/testcases/queens.tig
    mv $toolroot/testcases/queens.s $labroot/output/ref/queens.tig
  fi
fi

echo "compiling $COMP465LAB implementation"
/usr/bin/make

echo "generating $COMP465LAB compiler output"
# make my output directory
/bin/mkdir -p $labroot/output/mine

for i in {1..49}
do
  echo -n "test$i.tig "
  if [ $redir -eq 1 ]; then
    java $mainclass $toolroot/testcases/test$i.tig > $labroot/output/mine/test$i.tig 2>&1
  else
    java $mainclass $toolroot/testcases/test$i.tig
    mv $toolroot/testcases/test$i.s $labroot/output/mine/test$i.tig
  fi
done

echo -n "merge.tig "
if [ $redir -eq 1 ]; then
  java $mainclass $toolroot/testcases/merge.tig > $labroot/output/mine/merge.tig 2>&1
else
  java $mainclass $toolroot/testcases/merge.tig
  mv $toolroot/testcases/merge.s $labroot/output/mine/merge.tig
fi

echo "queens.tig"
if [ $redir -eq 1 ]; then
  java $mainclass $toolroot/testcases/queens.tig > $labroot/output/mine/queens.tig 2>&1
else
  java $mainclass $toolroot/testcases/queens.tig
  mv $toolroot/testcases/queens.s $labroot/output/mine/queens.tig
fi

echo "comparing $COMP465LAB output against reference compiler"
cd $labroot/output/ref
for i in {1..49}
do
  /usr/bin/diff -c test$i.tig ../mine/test$i.tig > ../diff.test$i
  if [ ! -s ../diff.test$i ]; then
    rm -f ../diff.test$i
    echo -e "test$i: [${GREEN}PASS${NC}]"
  else
    echo -e "test$i: [${RED}FAIL${NC}]"
  fi
done

/usr/bin/diff -c merge.tig ../mine/merge.tig > ../diff.merge
if [ ! -s ../diff.merge ]; then
  rm -f ../diff.merge
  echo -e "merge: [${GREEN}PASS${NC}]"
else
  echo -e "merge: [${RED}FAIL${NC}]"
fi

/usr/bin/diff -c queens.tig ../mine/queens.tig > ../diff.queens
if [ ! -s ../diff.queens ]; then
  rm -f ../diff.queens
  echo -e "queens: [${GREEN}PASS${NC}]"
else
  echo -e "queens: [${RED}FAIL${NC}]"
fi

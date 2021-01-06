# comp465-tools
Support files for COMP 465 Compiler projects

This repository has some important tools for your compiler implementation projects:

- `bin` - some shell scripts that are useful in running/testing your code
  - `install.sh` - configures your shell environment to build your compiler and the reference compiler
  - `setup465.sh` - changes the current lab you would like to work with
  - `runtest.sh` - runs your compiler against the reference compiler for regression testing
- `classes` - Java class files for the lexer and parser generators, as well as the reference compiler
- `examples` - this folder contains sample JLex and CUP files
- `testcases` - a set of Tiger program fragments to test for correctness and error cases
  - `merge.tig` - a recursive Tiger program to merge two lists
  - `queens.tig` - a Tiger program that iteratively solves the 8-queens problem

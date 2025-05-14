#!/bin/bash

#set -x
clang++ -g -O3 -mavx2 -Wall -pedantic example.C -o example -L${HOME}/local/gperftools/lib/ -lprofiler

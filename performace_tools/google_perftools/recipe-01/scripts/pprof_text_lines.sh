#!/bin/bash

CPUPROFILE=prof.data CPUPROFILE_FREQUENCY=1000 ./example 10000 100

export PATH=${PATH}:${HOME}/local/gperftools/bin/
pprof-symbolize --text --lines ./example prof.data

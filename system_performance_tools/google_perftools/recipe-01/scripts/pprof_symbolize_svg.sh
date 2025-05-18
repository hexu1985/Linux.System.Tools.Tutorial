#!/bin/bash

export PATH=${PATH}:${HOME}/local/gperftools/bin/
CPUPROFILE=prof.data CPUPROFILE_FREQUENCY=1000 ./example 10000 100
pprof-symbolize --svg ./example prof.data > prof.svg


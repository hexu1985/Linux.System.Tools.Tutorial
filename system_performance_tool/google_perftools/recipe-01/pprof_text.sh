#!/bin/bash

CPUPROFILE=prof.data CPUPROFILE_FREQUENCY=1000 ./example 10000 100

export PATH=${PATH}:${HOME}/local/gperftools/bin/
#pprof --text ./example prof.data
pprof-symbolize --text ./example prof.data
#pprof-symbolize --web ./example prof.data  # 交互式查看

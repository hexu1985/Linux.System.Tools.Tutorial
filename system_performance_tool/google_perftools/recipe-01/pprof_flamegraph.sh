#!/bin/bash

CPUPROFILE=prof.data CPUPROFILE_FREQUENCY=1000 ./example 10000 100
current_dir=$( cd $(dirname ${BASH_SOURCE[0]}) && pwd )

export PATH=${PATH}:${HOME}/local/gperftools/bin/
pprof-symbolize --collapsed ./example prof.data > cpu.prof
${current_dir}/flamegraph.pl cpu.prof > cpu.svg

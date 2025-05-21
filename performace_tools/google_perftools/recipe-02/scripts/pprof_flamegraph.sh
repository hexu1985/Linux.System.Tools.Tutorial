#!/bin/bash

# 启动程序
rm -f prof.data.*
CPUPROFILE=prof.data CPUPROFILE_FREQUENCY=1000 CPUPROFILESIGNAL=12 ./example &

# 获取PID
PID=$!

sleep 3

# 开始采集
kill -12 $PID

# 等待一段时间
sleep 15

# 结束采集
kill -12 $PID

current_dir=$( cd $(dirname ${BASH_SOURCE[0]}) && pwd )

export PATH=${PATH}:${HOME}/local/gperftools/bin/
pprof-symbolize --collapsed ./example prof.data.0 > cpu.prof
${current_dir}/flamegraph.pl cpu.prof > cpu.svg

kill -9 $PID

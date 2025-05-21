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

export PATH=${PATH}:${HOME}/local/gperftools/bin/
#pprof --text ./example prof.data
pprof-symbolize --text ./example prof.data.0
#pprof-symbolize --web ./example prof.data  # 交互式查看

kill -9 $PID

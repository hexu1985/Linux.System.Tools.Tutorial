# Google Perftools 对运行中程序的动态采集

是的，Google Perftools (gperftools) 可以动态采集已经运行中的程序，而不需要重启程序。以下是具体方法：

## 方法一：使用信号触发采集

1. **启动程序时加载 profiler**（但不立即开始采集）：
   ```bash
   LD_PRELOAD="/usr/lib/libprofiler.so" CPUPROFILE=/tmp/prof.out ./your_program
   ```
   或者如果程序已经静态链接了 profiler：
   ```bash
   CPUPROFILE=/tmp/prof.out ./your_program
   ```

2. **向运行中的进程发送信号开始/结束采集**：
   ```bash
   # 开始采集
   kill -SIGUSR1 <pid>
   
   # 结束采集
   kill -SIGUSR2 <pid>
   ```

## 方法二：使用环境变量控制

1. **启动程序时设置**：
   ```bash
   CPUPROFILE=/tmp/prof.out CPUPROFILESIGNAL=12 ./your_program
   ```

2. **动态控制采集**：
   ```bash
   # 开始采集
   kill -12 <pid>
   
   # 再次发送相同信号结束采集
   kill -12 <pid>
   ```

## 方法三：使用 pprof 工具附加

```bash
# 附加到运行中的进程并采集30秒
pprof --pdf ./your_program --seconds=30 <pid> > output.pdf
```

## 注意事项

1. **程序必须链接 profiler**：
   - 编译时加上 `-lprofiler`
   - 或者运行时通过 `LD_PRELOAD` 加载

2. **信号编号冲突**：
   - 默认使用 SIGUSR1/SIGUSR2，可能与程序其他功能冲突
   - 可以通过 `CPUPROFILESIGNAL` 指定其他信号

3. **多线程程序**：
   - 确保设置 `CPUPROFILE_REALTIME=1` 以获得准确的线程分析

4. **采集频率控制**：
   - 使用 `CPUPROFILE_FREQUENCY=X` 设置采样频率（Hz）

## 完整示例

```bash
# 启动程序
CPUPROFILE=/tmp/prof.out CPUPROFILESIGNAL=12 ./your_program &

# 获取PID
PID=$!

# 开始采集
kill -12 $PID

# 等待一段时间
sleep 30

# 结束采集
kill -12 $PID

# 生成报告
pprof --text ./your_program /tmp/prof.out
```

这种方法特别适合生产环境中不能轻易重启的长期运行服务。

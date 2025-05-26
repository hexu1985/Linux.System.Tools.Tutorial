# perf命令用法及输出说明

`perf`是Linux内核提供的一个强大的性能分析工具，它能够进行CPU性能分析、硬件事件统计、函数调用跟踪等。

## 基本用法

### 1. perf list
列出所有可监控的事件：
```bash
perf list
```
输出包括：
- 硬件事件（CPU性能计数器）
- 软件事件（内核计数器）
- 跟踪点事件
- 动态PMU事件

### 2. perf stat
统计命令执行的总体性能数据：
```bash
perf stat [options] <command>
```
常用选项：
- `-a`：统计所有CPU
- `-p <pid>`：统计指定进程
- `-e <event>`：指定要统计的事件
- `-r <n>`：重复运行命令n次并显示平均值

示例输出：
```
 Performance counter stats for 'ls':

          1.234567 task-clock                #    0.789 CPUs utilized          
                12 context-switches          #    0.010 M/sec                  
                 2 cpu-migrations            #    0.002 M/sec                  
               456 page-faults               #    0.369 M/sec                  
         1,234,567 cycles                    #    1.000 GHz                    
           876,543 stalled-cycles-frontend   #   70.98% frontend cycles idle   
           654,321 stalled-cycles-backend    #   53.00% backend  cycles idle   
         1,111,111 instructions              #    0.90  insns per cycle        
                                             #    0.79  stalled cycles per insn
           222,222 branches                  #  179.987 M/sec                  
            12,345 branch-misses             #    5.56% of all branches        

       0.001563456 seconds time elapsed
```

### 3. perf record
记录性能数据到文件（默认perf.data）：
```bash
perf record [options] <command>
```
常用选项：
- `-g`：记录调用图（call graph）
- `-F <n>`：采样频率（Hz）
- `-p <pid>`：记录指定进程
- `-e <event>`：指定要记录的事件

### 4. perf report
分析perf record记录的数据：
```bash
perf report [options]
```
常用选项：
- `-n`：显示样本数量
- `--stdio`：以文本形式显示（非交互式）
- `-g [type]`：显示调用图（callee, caller, graph等）

示例输出：
```
# Overhead  Command  Shared Object      Symbol
# ........  .......  .................  ................................
#
    42.50%  ls       libc-2.27.so       [.] _dl_addr
    23.70%  ls       [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
    10.20%  ls       libc-2.27.so       [.] __GI___strlen_sse2
     5.30%  ls       ls                 [.] main
     3.80%  ls       [kernel.kallsyms]  [k] do_syscall_64
```

### 5. perf top
实时显示系统性能统计，类似于top命令：
```bash
perf top
```
常用选项：
- `-e <event>`：指定要监控的事件
- `-p <pid>`：监控指定进程
- `-K`：隐藏内核符号
- `-U`：隐藏用户空间符号

## 高级用法

### 1. 函数调用图分析
```bash
perf record -g <command>
perf report -g graph
```
这会显示函数调用关系及时间分布。

### 2. 特定事件分析
```bash
perf stat -e cache-misses,cache-references <command>
```
统计缓存命中率。

### 3. 系统范围分析
```bash
perf record -a -g sleep 10
```
记录10秒内整个系统的性能数据。

### 4. 火焰图生成
结合FlameGraph工具生成直观的火焰图：
```bash
perf record -F 99 -a -g -- sleep 60
perf script | ./stackcollapse-perf.pl | ./flamegraph.pl > perf.svg
```

## 输出字段说明

1. **Overhead**：该符号在采样中出现的比例
2. **Command**：产生事件的命令名称
3. **Shared Object**：事件发生的模块（可执行文件或库）
4. **Symbol**：函数名或符号
5. **CPU Utilization**：CPU使用率
6. **Context Switches**：上下文切换次数
7. **Cache Misses/References**：缓存未命中/引用次数
8. **IPC (Instructions Per Cycle)**：每周期指令数，衡量CPU效率

## 注意事项

1. 需要root权限或设置`/proc/sys/kernel/perf_event_paranoid`为适当值
2. 某些功能需要内核支持（如call graph需要帧指针或DWARF调试信息）
3. 在高采样频率下可能会对系统性能产生影响

perf工具功能非常丰富，上述只是最常用的功能和输出说明，更多详细信息可参考`man perf`或在线文档。

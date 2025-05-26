# pidstat 命令用法及输出说明

`pidstat` 是一个用于监控 Linux 系统上各个进程资源使用情况的工具，它是 sysstat 工具包的一部分。

## 基本用法

```
pidstat [选项] [间隔时间] [次数]
```

## 常用选项

| 选项 | 说明 |
|------|------|
| -u   | 报告 CPU 使用情况（默认） |
| -r   | 报告内存使用情况 |
| -d   | 报告 I/O 使用情况 |
| -w   | 报告任务切换情况 |
| -p   | 指定进程 ID |
| -t   | 同时显示线程信息 |
| -h   | 在一行显示所有信息 |
| -l   | 显示进程的命令名和所有参数 |

## 输出说明

### CPU 使用情况 (`pidstat -u`)

```
Linux 5.4.0-91-generic (hostname) 	01/01/2022 	_x86_64_	(4 CPU)

03:10:00 PM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
03:10:01 PM     0         1    0.00    0.00    0.00    0.00    0.00     1  systemd
03:10:01 PM     0         6    0.00    0.00    0.00    0.00    0.00     0  kthreadd
```

- **UID**: 用户 ID
- **PID**: 进程 ID
- **%usr**: 进程在用户空间占用 CPU 的百分比
- **%system**: 进程在内核空间占用 CPU 的百分比
- **%guest**: 进程在虚拟机中占用 CPU 的百分比
- **%wait**: 进程等待 CPU 的时间百分比
- **%CPU**: 进程总的 CPU 使用百分比
- **CPU**: 进程运行的 CPU 编号
- **Command**: 进程名

### 内存使用情况 (`pidstat -r`)

```
03:10:00 PM   UID       PID  minflt/s  majflt/s     VSZ    RSS   %MEM  Command
03:10:01 PM     0         1      0.00      0.00  168056   9484   0.23  systemd
```

- **minflt/s**: 每秒次缺页错误数（minor faults，无需从磁盘加载内存页）
- **majflt/s**: 每秒主缺页错误数（major faults，需要从磁盘加载内存页）
- **VSZ**: 虚拟内存大小（KB）
- **RSS**: 常驻内存大小（KB）
- **%MEM**: 进程使用的物理内存百分比

### I/O 使用情况 (`pidstat -d`)

```
03:10:00 PM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s  Command
03:10:01 PM     0         1      0.00      0.00      0.00  systemd
```

- **kB_rd/s**: 每秒从磁盘读取的数据量（KB）
- **kB_wr/s**: 每秒写入磁盘的数据量（KB）
- **kB_ccwr/s**: 每秒被取消的写入磁盘的数据量（KB）

## 实用示例

1. 监控所有进程的 CPU 使用情况，每 2 秒刷新一次：
   ```
   pidstat 2
   ```

2. 监控特定进程（PID=1234）的内存使用情况：
   ```
   pidstat -r -p 1234 1 5
   ```

3. 监控所有进程的 I/O 统计，每 1 秒刷新，共显示 3 次：
   ```
   pidstat -d 1 3
   ```

4. 综合显示 CPU、内存和 I/O 信息：
   ```
   pidstat -urd -h 1 5
   ```

5. 显示线程级别的统计信息：
   ```
   pidstat -t -p 1234 1
   ```

`pidstat` 是一个强大的进程监控工具，可以帮助系统管理员识别资源占用高的进程，进行性能分析和故障排查。

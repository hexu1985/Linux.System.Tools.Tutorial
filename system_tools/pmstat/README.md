# pmstat 命令用法及输出说明

`pmstat` 是 Performance Co-Pilot (PCP) 工具集中的一个命令，用于显示系统性能统计信息。它提供了类似于 `vmstat` 或 `sar` 的功能，但基于 PCP 框架。

## 基本用法

```bash
pmstat [选项] [间隔时间] [次数]
```

### 常用选项

| 选项 | 描述 |
|------|------|
| `-A` | 显示所有统计信息 |
| `-a` | 显示存档模式 |
| `-h` | 显示帮助信息 |
| `-t` | 显示时间戳 |
| `-T` | 指定时间格式 |
| `-V` | 显示版本信息 |
| `-z` | 使用本地时区 |
| `-Z` | 指定时区 |

## 输出说明

典型输出示例：

```
Time   loadavg   memused  membuff  memcache  memfree   swpused  swpfree  netsam   netrecv   netsend   diskrio   diskrbyt   diskwio   diskwbyt   cpu%usr  cpu%sys  cpu%idle
16:10     0.12     45.2%    12.1%     15.3%     27.4%      0.0%   100.0%    0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.0      0.0     99.9
```

各列含义：

| 列名 | 描述 |
|------|------|
| Time | 当前时间 |
| loadavg | 系统平均负载 (1分钟) |
| memused | 已用内存百分比 |
| membuff | 缓冲区内存百分比 |
| memcache | 缓存内存百分比 |
| memfree | 空闲内存百分比 |
| swpused | 已用交换空间百分比 |
| swpfree | 空闲交换空间百分比 |
| netsam | 网络采样数 |
| netrecv | 网络接收数据量 (KB/s) |
| netsend | 网络发送数据量 (KB/s) |
| diskrio | 磁盘读操作次数 |
| diskrbyt | 磁盘读取字节数 |
| diskwio | 磁盘写操作次数 |
| diskwbyt | 磁盘写入字节数 |
| cpu%usr | CPU用户空间使用百分比 |
| cpu%sys | CPU系统空间使用百分比 |
| cpu%idle | CPU空闲百分比 |

## 示例

1. 每5秒显示一次统计信息，共显示3次：
   ```bash
   pmstat 5 3
   ```

2. 显示带时间戳的统计信息：
   ```bash
   pmstat -t 2
   ```

3. 显示所有可用的统计信息：
   ```bash
   pmstat -A 1
   ```

`pmstat` 是监控系统性能的强大工具，特别适合在 PCP 环境中使用，可以与其他 PCP 工具如 `pmrep` 和 `pmchart` 配合使用进行更深入的分析。

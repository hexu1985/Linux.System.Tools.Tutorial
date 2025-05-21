# SAR命令用法及输出说明

SAR(System Activity Reporter)是Linux系统性能监控工具，属于sysstat软件包的一部分，用于收集、报告和保存系统活动信息。

## 基本用法

```
sar [选项] [间隔时间] [次数]
```

常用选项：
- `-A`：显示所有报告
- `-u`：显示CPU使用率
- `-r`：显示内存使用情况
- `-b`：显示I/O和传输速率统计
- `-n`：显示网络统计
- `-d`：显示块设备(磁盘)活动
- `-q`：显示队列长度和平均负载
- `-B`：显示分页统计
- `-P`：指定CPU编号
- `-o`：将输出保存到二进制文件
- `-f`：从二进制文件读取数据

## 输出说明

### 1. CPU使用率(`sar -u`)

```
Linux 5.4.0-91-generic (hostname) 	12/01/2022 	_x86_64_	(4 CPU)

12:00:01 AM     CPU     %user     %nice   %system   %iowait    %steal     %idle
12:10:01 AM     all      5.12      0.01      1.03      0.12      0.00     93.72
```

- `%user`：用户空间CPU使用率
- `%nice`：低优先级进程CPU使用率
- `%system`：内核空间CPU使用率
- `%iowait`：等待I/O的CPU时间百分比
- `%steal`：虚拟环境中的CPU被偷取时间
- `%idle`：CPU空闲时间百分比

### 2. 内存使用情况(`sar -r`)

```
12:00:01 AM kbmemfree kbmemused  %memused kbbuffers  kbcached  kbcommit   %commit
12:10:01 AM   1023456   8123456     88.81    123456    456789   5123456     25.12
```

- `kbmemfree`：空闲内存量(KB)
- `kbmemused`：已使用内存量(KB)
- `%memused`：内存使用率
- `kbbuffers`：缓冲区使用的内存量(KB)
- `kbcached`：缓存使用的内存量(KB)
- `kbcommit`：当前工作负载所需内存(KB)
- `%commit`：所需内存占总内存百分比

### 3. 磁盘I/O统计(`sar -b`)

```
12:00:01 AM       tps      rtps      wtps   bread/s   bwrtn/s
12:10:01 AM      5.12      1.23      3.89     12.34     56.78
```

- `tps`：每秒传输次数
- `rtps`：每秒读请求数
- `wtps`：每秒写请求数
- `bread/s`：每秒读取的块数
- `bwrtn/s`：每秒写入的块数

### 4. 网络统计(`sar -n DEV`)

```
12:00:01 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s
12:10:01 AM      eth0     12.34     56.78      1.23      5.67      0.00      0.00      0.12
```

- `IFACE`：网络接口
- `rxpck/s`：每秒接收的数据包
- `txpck/s`：每秒发送的数据包
- `rxkB/s`：每秒接收的KB数
- `txkB/s`：每秒发送的KB数
- `rxcmp/s`：每秒接收的压缩包数
- `txcmp/s`：每秒发送的压缩包数
- `rxmcst/s`：每秒接收的多播包数

## 实用示例

1. 实时监控CPU使用率，每2秒刷新一次：
   ```
   sar -u 2
   ```

2. 监控内存使用情况，每5秒刷新，共显示3次：
   ```
   sar -r 5 3
   ```

3. 查看特定日期的历史数据(需先配置数据收集)：
   ```
   sar -u -f /var/log/sa/sa01
   ```

4. 监控所有核心的CPU使用率：
   ```
   sar -P ALL 1 3
   ```

5. 综合监控(CPU、内存、磁盘、网络)：
   ```
   sar -A 1 3
   ```

## 注意事项

1. 使用前需确保sysstat服务已安装并运行：
   ```
   sudo apt install sysstat
   sudo systemctl enable sysstat
   sudo systemctl start sysstat
   ```

2. 历史数据通常保存在`/var/log/sa/`目录下，文件名为sa[日期]

3. 默认情况下，sar数据每10分钟收集一次，可通过编辑`/etc/cron.d/sysstat`调整频率

4. 对于长期监控，建议使用`-o`选项将数据保存到二进制文件，之后用`-f`读取分析

# top命令用法及输出说明

`top` 是 Linux 系统中一个实时动态查看系统运行状态的命令行工具，类似于 Windows 的任务管理器。它可以显示 **CPU、内存、进程、负载** 等关键系统信息，并允许用户进行交互式操作（如排序、终止进程等）。

---

## **1. 基本用法**
### **启动 `top`**
```bash
top
```
默认情况下，`top` 会实时刷新（通常每 3 秒更新一次），按 **`q`** 退出。

### **常用启动选项**
| 选项 | 说明 |
|------|------|
| `top -d 秒数` | 设置刷新间隔（如 `top -d 1` 每秒刷新） |
| `top -n 次数` | 刷新指定次数后自动退出（如 `top -n 2`） |
| `top -p PID` | 仅监视指定进程（如 `top -p 1234`） |
| `top -u 用户名` | 仅显示指定用户的进程（如 `top -u root`） |
| `top -b` | 以批处理模式运行（适合输出到文件） |
| `top -H` | 显示线程（而不是进程） |

---

## **2. `top` 输出解析**
`top` 界面分为 **顶部汇总信息** 和 **进程列表** 两部分：

### **（1）顶部汇总信息**
```
top - 15:30:45 up 2 days,  3:45,  2 users,  load average: 0.15, 0.10, 0.05
Tasks: 120 total,   2 running, 118 sleeping,   0 stopped,   0 zombie
%Cpu(s):  5.3 us,  1.2 sy,  0.0 ni, 93.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   7856.4 total,   1024.2 free,   4096.0 used,   2736.2 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   3200.0 avail Mem
```
- **第 1 行（系统运行信息）**：
  - `15:30:45`：当前时间。
  - `up 2 days, 3:45`：系统已运行时间。
  - `load average: 0.15, 0.10, 0.05`：1 分钟、5 分钟、15 分钟的平均负载（`< CPU核心数` 表示正常）。

- **第 2 行（任务状态）**：
  - `Tasks: 120 total`：总进程数。
  - `2 running`：正在运行的进程数。
  - `118 sleeping`：休眠的进程数。
  - `0 stopped`：停止的进程数。
  - `0 zombie`：僵尸进程数（若不为 0，需检查异常进程）。

- **第 3 行（CPU 使用率）**：
  - `5.3 us`：用户空间程序占用 CPU 百分比。
  - `1.2 sy`：内核空间占用 CPU 百分比。
  - `93.5 id`：空闲 CPU 百分比。
  - `0.0 wa`：I/O 等待占用 CPU 百分比（若较高，可能磁盘瓶颈）。

- **第 4 行（内存使用）**：
  - `7856.4 total`：总物理内存（MiB）。
  - `1024.2 free`：空闲内存。
  - `4096.0 used`：已使用内存。
  - `2736.2 buff/cache`：缓存和缓冲区内存（可被回收）。

- **第 5 行（Swap 交换分区）**：
  - `2048.0 total`：Swap 总大小。
  - `2048.0 free`：空闲 Swap（若 `used` 持续增长，说明物理内存不足）。

---

### **（2）进程列表**
```
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 1234 root      20   0  123456  78900   1234 R   6.2  1.0   0:10.23 firefox
 5678 mysql     20   0  1.2g   500000  20000 S   2.5  6.3  10:45.67 mysqld
```
| 列名 | 说明 |
|------|------|
| `PID` | 进程 ID |
| `USER` | 进程所有者 |
| `PR` | 进程优先级（越小优先级越高） |
| `NI` | Nice 值（-20 最高优先级，19 最低） |
| `VIRT` | 进程占用的虚拟内存（KB） |
| `RES` | 进程占用的物理内存（KB） |
| `SHR` | 共享内存大小（KB） |
| `S` | 进程状态（`R`=运行, `S`=休眠, `Z`=僵尸） |
| `%CPU` | CPU 使用率 |
| `%MEM` | 内存使用率 |
| `TIME+` | 进程占用 CPU 总时间 |
| `COMMAND` | 进程名称或命令行 |

---

## **3. 交互命令（运行时按键操作）**
| 按键 | 功能 |
|------|------|
| `q` | 退出 `top` |
| `k` | 终止进程（输入 PID 后回车） |
| `r` | 修改进程优先级（`renice`） |
| `P` | 按 CPU 使用率排序（默认） |
| `M` | 按内存使用率排序 |
| `T` | 按运行时间排序 |
| `1` | 显示所有 CPU 核心的单独使用率 |
| `h` | 显示帮助 |
| `Shift + <` 或 `Shift + >` | 向左/向右滚动进程列表 |

---

## **4. 常见使用场景**
### **（1）查找高 CPU 占用进程**
```bash
top -o %CPU  # 按 CPU 排序
```
### **（2）查找高内存占用进程**
```bash
top -o %MEM  # 按内存排序
```
### **（3）监控特定用户的进程**
```bash
top -u mysql  # 仅显示 mysql 用户的进程
```
### **（4）输出到文件（用于分析）**
```bash
top -b -n 1 > top.log  # 保存当前快照
```

---

## **5. 类似命令**
- `htop`：增强版 `top`（支持鼠标操作，更直观）。
- `vmstat`：查看系统整体资源使用情况。
- `ps aux`：静态查看进程列表。

---

### **总结**
`top` 是 Linux 系统管理和性能排查的必备工具，熟练掌握它可以快速定位 CPU/内存瓶颈、僵尸进程等问题。建议结合 `htop` 使用，体验更友好。

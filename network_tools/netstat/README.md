# netstat命令用法及输出说明

`netstat`（Network Statistics）是一个用于显示网络连接、路由表、接口统计等网络相关信息的命令行工具，在Linux、Unix和Windows系统中均可使用。以下是其常见用法及输出说明：

---

### **一、基本用法**
#### 1. 显示所有活动连接
```bash
netstat -a
```
- **说明**：列出所有活动的TCP和UDP连接（包括监听和非监听状态）。

#### 2. 显示TCP连接
```bash
netstat -at
```
- **说明**：仅显示TCP协议的连接。

#### 3. 显示UDP连接
```bash
netstat -au
```
- **说明**：仅显示UDP协议的连接。

#### 4. 显示监听中的端口
```bash
netstat -l
```
- **说明**：列出所有处于监听（等待连接）状态的端口。

#### 5. 显示监听中的TCP端口
```bash
netstat -lt
```
- **说明**：仅显示监听中的TCP端口。

#### 6. 显示进程ID和程序名
```bash
netstat -p
```
- **说明**：显示每个连接对应的进程ID（PID）和程序名称（需root权限）。

#### 7. 显示数字格式的地址和端口
```bash
netstat -n
```
- **说明**：禁用主机名和服务名的解析，直接显示IP地址和端口号（更快）。

#### 8. 组合常用参数
```bash
netstat -tulnp
```
- **说明**：显示所有监听中的TCP/UDP端口，并显示进程信息（数字格式）。

---

### **二、输出字段说明**
执行`netstat -tulnp`后的典型输出示例：
```plaintext
Proto Recv-Q Send-Q Local Address     Foreign Address   State       PID/Program name
tcp        0      0 0.0.0.0:22        0.0.0.0:*         LISTEN      1234/sshd
tcp6       0      0 :::80             :::*              LISTEN      5678/nginx
udp        0      0 127.0.0.1:53      0.0.0.0:*                     91011/named
```

1. **Proto**  
   - 协议类型（TCP/UDP）。

2. **Recv-Q / Send-Q**  
   - 接收/发送队列中的数据包数量（0表示无积压）。

3. **Local Address**  
   - 本地IP和端口（`0.0.0.0`或`::`表示所有接口）。

4. **Foreign Address**  
   - 远程IP和端口（`*`表示未连接）。

5. **State**  
   - 连接状态（仅TCP有效）：
     - `LISTEN`：监听中。
     - `ESTABLISHED`：已建立连接。
     - `TIME_WAIT`：等待关闭。
     - 其他状态：`SYN_SENT`、`CLOSE_WAIT`等。

6. **PID/Program name**  
   - 进程ID和程序名称（需`-p`参数）。

---

### **三、其他实用命令**
#### 1. 显示路由表
```bash
netstat -r
```
- 等同于`route -n`，显示内核路由表。

#### 2. 显示网络接口统计
```bash
netstat -i
```
- 显示网卡收发数据包的统计信息（类似`ifconfig`）。

#### 3. 显示网络协议统计
```bash
netstat -s
```
- 显示TCP、UDP、ICMP等协议的汇总统计（如丢包数、错误数）。

---

### **四、注意事项**
1. **替代工具**  
   - 在较新系统中，`ss`（Socket Statistics）和`ip`命令已逐步替代`netstat`，例如：
     ```bash
     ss -tulnp  # 更高效的替代命令
     ```

2. **权限要求**  
   - 查看进程信息（`-p`）通常需要`root`权限。

3. **Windows系统**  
   - Windows版的`netstat`参数类似，但输出格式略有不同（如无`-p`显示进程名的功能）。

---

通过`netstat`可以快速诊断网络连接问题，如端口占用、服务监听状态等。如需更详细信息，建议结合`grep`过滤输出（例如`netstat -anp | grep 80`）。

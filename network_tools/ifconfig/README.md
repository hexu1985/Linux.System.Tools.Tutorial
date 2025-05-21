# ifconfig命令用法及输出说明

`ifconfig`（interface config）是一个用于配置和显示网络接口参数的命令行工具，常用于类Unix系统（如Linux、macOS）。虽然现代Linux系统推荐使用`ip`命令（如`ip addr`），但`ifconfig`仍被广泛使用。以下是其用法及输出说明：

---

### **基本用法**
```bash
ifconfig                  # 显示所有活跃的网络接口
ifconfig -a               # 显示所有接口（包括未激活的）
ifconfig <接口名>         # 显示指定接口（如eth0、wlan0）
ifconfig <接口名> up      # 启用接口
ifconfig <接口名> down    # 禁用接口
ifconfig <接口名> <IP地址> netmask <子网掩码>  # 配置IP和掩码
```

---

### **输出字段说明**
以以下典型输出为例：
```bash
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.100  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::20c:29ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:12:34:56  txqueuelen 1000  (Ethernet)
        RX packets 12000  bytes 1000000 (1.0 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8000  bytes 800000 (800 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

1. **接口名（eth0）**  
   - 网络接口的名称（如`eth0`为有线网卡，`wlan0`为无线网卡）。

2. **flags（状态标志）**  
   - `UP`：接口已启用。
   - `BROADCAST`：支持广播。
   - `RUNNING`：接口正在工作。
   - `MULTICAST`：支持组播。

3. **MTU（最大传输单元）**  
   - 数据包大小的上限（默认1500字节）。

4. **IPv4地址（inet）**  
   - `inet`：IPv4地址（如`192.168.1.100`）。
   - `netmask`：子网掩码（如`255.255.255.0`）。
   - `broadcast`：广播地址（如`192.168.1.255`）。

5. **IPv6地址（inet6）**  
   - `inet6`：IPv6地址及前缀长度（如`fe80::...`）。

6. **MAC地址（ether）**  
   - 网卡的物理地址（如`00:0c:29:12:34:56`）。

7. **流量统计**  
   - `RX`（Receive）：接收的数据包/字节数。
   - `TX`（Transmit）：发送的数据包/字节数。
   - `errors/dropped`：错误或丢弃的数据包数。

---

### **常见操作示例**
1. **临时设置IP地址**  
   ```bash
   sudo ifconfig eth0 192.168.1.200 netmask 255.255.255.0
   ```

2. **启用/禁用接口**  
   ```bash
   sudo ifconfig eth0 down   # 关闭网卡
   sudo ifconfig eth0 up     # 启动网卡
   ```

3. **启用混杂模式（监听所有流量）**  
   ```bash
   sudo ifconfig eth0 promisc
   ```

---

### **注意事项**
1. **权限需求**：配置接口通常需要`sudo`或root权限。
2. **临时生效**：通过`ifconfig`的配置重启后会失效，持久化需修改网络配置文件（如`/etc/network/interfaces`或NetworkManager）。
3. **替代命令**：在Linux中，`ip`命令更强大，例如：
   ```bash
   ip addr show      # 替代ifconfig
   ip link set eth0 up  # 替代ifconfig eth0 up
   ```

---

通过`ifconfig`可以快速查看和调整网络接口，适合故障排查或临时配置。如需更高级功能，建议学习`ip`命令或网络管理工具（如`nmcli`）。

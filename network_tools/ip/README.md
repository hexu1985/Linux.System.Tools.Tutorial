# ip命令用法及输出说明

`ip` 命令是 Linux 系统中功能强大的网络配置工具，用于替代传统的 `ifconfig`、`route` 等命令。它支持网络接口、路由、ARP、隧道等多项配置。以下是常见用法及输出说明：

---

### **1. 基本语法**
```bash
ip [OPTIONS] OBJECT {COMMAND | help}
```
- **OBJECT**：操作对象（如 `link`、`addr`、`route`、`neigh` 等）。
- **COMMAND**：具体操作（如 `show`、`add`、`delete`、`flush` 等）。

---

### **2. 常用对象及命令**

#### **（1）网络接口管理（`link`）**
- **查看所有接口**：
  ```bash
  ip link show
  ```
  **输出示例**：
  ```
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
  2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
      link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
  ```
  - **关键字段**：
    - `lo`、`eth0`：接口名称。
    - `state UP/DOWN`：接口状态（是否启用）。
    - `mtu`：最大传输单元。
    - `link/ether`：MAC 地址。

- **启用/禁用接口**：
  ```bash
  ip link set eth0 up    # 启用
  ip link set eth0 down  # 禁用
  ```

---

#### **（2）IP 地址管理（`addr`）**
- **查看所有接口的 IP 地址**：
  ```bash
  ip addr show
  ```
  **输出示例**：
  ```
  2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
      link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
      inet 192.168.1.100/24 brd 192.168.1.255 scope global dynamic eth0
         valid_lft 86300sec preferred_lft 86300sec
      inet6 fe80::5054:ff:fe12:3456/64 scope link 
         valid_lft forever preferred_lft forever
  ```
  - **关键字段**：
    - `inet`：IPv4 地址及子网掩码（`/24`）。
    - `inet6`：IPv6 地址。
    - `scope global`：全局有效地址；`scope link`：仅本地链路有效。

- **添加/删除 IP 地址**：
  ```bash
  ip addr add 192.168.1.200/24 dev eth0  # 添加
  ip addr del 192.168.1.200/24 dev eth0  # 删除
  ```

---

#### **（3）路由管理（`route`）**
- **查看路由表**：
  ```bash
  ip route show
  ```
  **输出示例**：
  ```
  default via 192.168.1.1 dev eth0 proto static metric 100 
  192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100 
  10.0.0.0/8 via 10.1.1.1 dev tun0
  ```
  - **关键字段**：
    - `default via 192.168.1.1`：默认网关。
    - `192.168.1.0/24 dev eth0`：直连网络。
    - `proto kernel`：由内核自动生成。

- **添加/删除路由**：
  ```bash
  ip route add 10.0.0.0/8 via 10.1.1.1 dev tun0  # 添加
  ip route del 10.0.0.0/8                         # 删除
  ```

---

#### **（4）ARP 邻居表（`neigh`）**
- **查看 ARP 缓存**：
  ```bash
  ip neigh show
  ```
  **输出示例**：
  ```
  192.168.1.1 dev eth0 lladdr 00:11:22:33:44:55 REACHABLE
  ```
  - **关键字段**：
    - `lladdr`：MAC 地址。
    - `REACHABLE`：邻居状态（可达）。

---

#### **（5）统计信息（`-s` 选项）**
- **查看接口统计信息**：
  ```bash
  ip -s link show eth0
  ```
  **输出示例**：
  ```
  2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
      link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
      RX: bytes  packets  errors  dropped overrun mcast   
      123456789  1000     0       0       0       0
      TX: bytes  packets  errors  dropped carrier collsns 
      987654321  800      0       0       0       0
  ```
  - **RX/TX**：接收/发送的数据包统计。

---

### **3. 其他实用命令**
- **清空所有 IP 地址**：
  ```bash
  ip addr flush dev eth0
  ```
- **查看帮助**：
  ```bash
  ip addr help
  ip route help
  ```

---

### **4. 与传统命令对比**
| 功能           | `ip` 命令                     | 传统命令          |
|----------------|-------------------------------|-------------------|
| 查看接口       | `ip link show`                | `ifconfig -a`     |
| 查看 IP        | `ip addr show`                | `ifconfig`        |
| 查看路由       | `ip route show`               | `route -n`        |
| 查看 ARP       | `ip neigh show`               | `arp -n`          |

---

### **5. 注意事项**
- 需要 root 权限执行配置操作（如 `sudo ip ...`）。
- 使用 `-c` 选项可彩色化输出（例如 `ip -c addr`）。

通过灵活组合 `ip` 的子命令，可以高效管理网络配置。如需更详细帮助，可查阅 `man ip`。

# Nethogs 命令用法及输出说明

Nethogs 是一个开源的网络监控工具，用于按进程实时显示网络带宽使用情况。

## 基本用法

```bash
nethogs [options] [device]
```

### 常用选项

- `-d` 或 `--delay`：刷新间隔时间（秒），默认1秒
  ```bash
  nethogs -d 2
  ```

- `-t` 或 `--tracemode`：跟踪模式（更详细的输出）
  ```bash
  nethogs -t
  ```

- `-V` 或 `--version`：显示版本信息
- `-h` 或 `--help`：显示帮助信息
- `-p` 或 `--promisc`：混杂模式（监听所有流量）
- `-c` 或 `--count`：刷新次数后退出
  ```bash
  nethogs -c 5
  ```

### 指定网络接口

```bash
nethogs eth0     # 监控eth0接口
nethogs wlan0    # 监控wlan0无线接口
```

## 输出说明

Nethogs 的输出通常包含以下列：

```
PID    USER    PROGRAM              DEV        SENT      RECEIVED
```

- **PID**：进程ID
- **USER**：运行该进程的用户
- **PROGRAM**：程序名称或命令行
- **DEV**：使用的网络接口
- **SENT**：该进程发送的数据量（KB/s）
- **RECEIVED**：该进程接收的数据量（KB/s）

## 交互命令

在 Nethogs 运行时，可以使用以下快捷键：

- `m`：在 KB/s、KB、B、MB 等单位间切换显示
- `r`：按接收流量排序
- `s`：按发送流量排序
- `q`：退出程序

## 示例输出

```
PID    USER     PROGRAM              DEV        SENT      RECEIVED
1234   root     /usr/bin/firefox     eth0       12.3      45.6
5678   bob      /usr/bin/ssh         eth0       1.2       0.8
9101   alice    /usr/bin/wget        eth0       0.0       1024.5
```

## 安装方法

### Debian/Ubuntu

```bash
sudo apt-get install nethogs
```

### RHEL/CentOS

```bash
sudo yum install nethogs
```

### 从源码编译

```bash
git clone https://github.com/raboof/nethogs
cd nethogs
make && sudo make install
```

Nethogs 是一个非常有用的工具，特别适合排查哪个进程占用了大量网络带宽。

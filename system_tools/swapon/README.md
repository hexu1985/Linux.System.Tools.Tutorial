# swapon 命令用法及输出说明

`swapon` 是 Linux 系统中用于激活交换空间（swap space）的命令。交换空间是当物理内存（RAM）不足时，系统用来临时存储内存数据的一个特殊区域。

## 基本用法

### 1. 显示当前交换空间信息

```bash
swapon --show
```

或

```bash
swapon -s
```

**示例输出**：
```
NAME      TYPE      SIZE USED PRIO
/dev/sda5 partition   4G   0B   -1
```

**字段说明**：
- `NAME`：交换设备或文件的名称
- `TYPE`：类型（partition 表示分区，file 表示交换文件）
- `SIZE`：交换空间总大小
- `USED`：已使用的交换空间
- `PRIO`：优先级（数值越高，优先级越高）

### 2. 激活交换分区或文件

```bash
sudo swapon /dev/sdXN  # 激活分区
sudo swapon /swapfile  # 激活交换文件
```

### 3. 激活所有在 /etc/fstab 中标记为 swap 的设备

```bash
sudo swapon -a
```

### 4. 设置交换空间优先级

```bash
sudo swapon -p 10 /dev/sdXN
```
优先级越高（数值越大）的交换空间会被优先使用

## 常用选项

| 选项 | 说明 |
|------|------|
| `-a`, `--all` | 激活所有在 /etc/fstab 中标记为 swap 的设备 |
| `-d`, `--discard` | 启用交换空间的 discard 功能 |
| `-e`, `--ifexists` | 跳过不存在的设备而不报错 |
| `-f`, `--fixpgsz` | 如果需要则重新初始化交换空间 |
| `-h`, `--help` | 显示帮助信息 |
| `-p`, `--priority` | 设置交换空间优先级 |
| `-s`, `--summary` | 显示交换空间使用摘要 |
| `-v`, `--verbose` | 详细模式 |
| `-V`, `--version` | 显示版本信息 |

## 注意事项

1. 使用 `swapon` 通常需要 root 权限（使用 sudo）
2. 交换分区或文件需要先使用 `mkswap` 命令初始化
3. 要使交换空间在系统启动时自动激活，需要在 /etc/fstab 中添加相应条目
4. 使用 `swapoff` 命令可以停用交换空间

## 示例

1. 激活交换文件并设置高优先级：
```bash
sudo swapon -p 100 /swapfile
```

2. 显示详细交换信息：
```bash
sudo swapon --show --verbose
```

3. 激活所有交换空间：
```bash
sudo swapon -a
```

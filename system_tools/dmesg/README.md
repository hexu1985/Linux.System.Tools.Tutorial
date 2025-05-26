# dmesg 命令用法及输出说明

`dmesg` 是 Linux 系统中用于显示内核环形缓冲区(kernel ring buffer)内容的命令，它包含了内核启动信息以及系统运行过程中的各种内核消息。

## 基本用法

```bash
dmesg [选项]
```

## 常用选项

| 选项 | 说明 |
|------|------|
| `-H`, `--human` | 人类可读格式输出 |
| `-T`, `--ctime` | 显示可读的时间戳 |
| `-w`, `--follow` | 实时监控新消息(类似 tail -f) |
| `-l`, `--level <级别>` | 按级别过滤消息(emerg,alert,crit,err,warn,notice,info,debug) |
| `-f`, `--facility <设施>` | 按设施过滤消息(kern,user,mail,daemon等) |
| `-k`, `--kernel` | 只显示内核消息 |
| `-u`, `--userspace` | 只显示用户空间消息 |
| `-x`, `--decode` | 解码设施和级别为可读字符串 |
| `-n`, `--console-level <级别>` | 设置控制台日志级别 |
| `-C`, `--clear` | 清除环形缓冲区 |
| `-r`, `--raw` | 显示原始消息格式 |
| `-L`, `--color` | 彩色显示 |
| `-S`, `--syslog` | 强制使用syslog(2)而不是/dev/kmsg |

## 输出说明

`dmesg` 输出通常包含以下信息：

1. **时间戳**：消息产生的时间(可以使用 `-T` 显示可读时间)
2. **设施和级别**：如 `kern info` 或 `user warning`
3. **消息内容**：具体的系统事件描述

### 常见输出示例

```
[    0.000000] Linux version 5.4.0-42-generic (buildd@lcy01-amd64-001) (gcc version 9.3.0 (Ubuntu 9.3.0-10ubuntu2)) #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 2020
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-42-generic root=UUID=xxxx ro quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
```

## 实用示例

1. **查看最近的系统消息**：
   ```bash
   dmesg | tail -20
   ```

2. **查看带有可读时间戳的消息**：
   ```bash
   dmesg -T
   ```

3. **只查看错误和警告消息**：
   ```bash
   dmesg -l err,warn
   ```

4. **实时监控新内核消息**：
   ```bash
   dmesg -w
   ```

5. **查看USB设备相关消息**：
   ```bash
   dmesg | grep -i usb
   ```

6. **查看硬盘/存储设备消息**：
   ```bash
   dmesg | grep -i sda
   ```

7. **查看网络相关消息**：
   ```bash
   dmesg | grep -i eth
   ```

8. **彩色显示并按级别分类**：
   ```bash
   dmesg -L -x
   ```

`dmesg` 是诊断系统启动问题和硬件问题的强大工具，特别是在系统无法正常启动时，可以通过查看这些日志来了解问题所在。

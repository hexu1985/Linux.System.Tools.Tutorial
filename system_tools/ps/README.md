# `ps` 命令用法及输出说明

`ps` (Process Status) 命令用于显示当前系统的进程状态信息，是Linux/Unix系统中非常重要的进程管理工具。

## 基本用法

```bash
ps [options]
```

## 常用选项

| 选项 | 说明 |
|------|------|
| `-A` 或 `-e` | 显示所有进程 |
| `-a` | 显示同一终端下的所有程序 |
| `-f` | 显示完整格式的输出 |
| `-u` | 显示指定用户的进程 |
| `-x` | 显示没有控制终端的进程 |
| `-l` | 长格式输出 |
| `-j` | 任务格式输出 |
| `-H` | 显示进程层次结构 |
| `--forest` | 以树状结构显示进程 |
| `aux` | BSD风格组合选项(常用) |
| `-ef` | UNIX风格组合选项(常用) |

## 常用组合

1. **查看所有进程**
   ```bash
   ps -ef
   ps aux
   ```

2. **查看特定用户的进程**
   ```bash
   ps -u username
   ```

3. **查看特定进程**
   ```bash
   ps -p PID
   ```

4. **树状显示进程**
   ```bash
   ps -ef --forest
   ```

5. **查看线程信息**
   ```bash
   ps -eLf
   ```

## 输出字段说明

以 `ps aux` 输出为例：

```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  37808  5928 ?        Ss   May01   0:02 /sbin/init
```

- **USER**: 进程所有者
- **PID**: 进程ID
- **%CPU**: CPU使用百分比
- **%MEM**: 内存使用百分比
- **VSZ**: 虚拟内存大小(KB)
- **RSS**: 常驻内存大小(KB)
- **TTY**: 终端关联
- **STAT**: 进程状态
  - `R`: 运行中
  - `S`: 可中断睡眠
  - `D`: 不可中断睡眠
  - `Z`: 僵尸进程
  - `T`: 停止状态
  - `<`: 高优先级
  - `N`: 低优先级
  - `s`: 会话首进程
  - `l`: 多线程
  - `+`: 前台进程组
- **START**: 进程启动时间
- **TIME**: CPU占用时间
- **COMMAND**: 命令名称/命令行

## 实际应用示例

1. 查找特定进程：
   ```bash
   ps aux | grep nginx
   ```

2. 按CPU使用排序：
   ```bash
   ps aux --sort=-%cpu | head
   ```

3. 按内存使用排序：
   ```bash
   ps aux --sort=-%mem | head
   ```

4. 显示完整命令行：
   ```bash
   ps -f
   ```

5. 查看进程环境变量：
   ```bash
   ps e -p PID
   ```

`ps` 命令功能强大，可以通过组合不同选项获取所需的进程信息，是系统管理和故障排查的重要工具。

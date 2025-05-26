# `time` 命令用法及输出说明

`time` 命令用于测量命令的执行时间，显示实际时间、用户CPU时间和系统CPU时间。

## 基本用法

```bash
time [options] command [arguments]
```

## 输出说明

执行后通常显示如下格式的输出：

```
real    0m1.003s
user    0m0.002s
sys     0m0.004s
```

- **real** (实际时间): 从开始到结束的墙上时钟时间(真实时间)
- **user** (用户CPU时间): 进程在用户模式下消耗的CPU时间
- **sys** (系统CPU时间): 进程在内核模式下消耗的CPU时间

## 两种不同的time命令

1. **Shell内置time命令** (如Bash中的time)
   - 输出格式较简单
   - 用法: 直接输入 `time command`

2. **GNU time命令** (`/usr/bin/time`)
   - 功能更强大
   - 需要完整路径或使用`\time`调用
   - 提供更多信息(内存使用、上下文切换等)

## GNU time的常用选项

```bash
/usr/bin/time -v command  # 显示详细信息
/usr/bin/time -f format command  # 自定义输出格式
/usr/bin/time -o file command  # 输出到文件
```

## 示例

1. 基本使用:
```bash
time ls -l
```

2. 使用GNU time并显示详细信息:
```bash
/usr/bin/time -v ls -l
```

3. 自定义输出格式:
```bash
/usr/bin/time -f "\nReal: %e sec\nUser: %U sec\nSys: %S sec" ls -l
```

## 格式说明符(GNU time)

- `%E`: 实际时间(格式: [小时:]分钟:秒)
- `%e`: 实际时间(秒)
- `%U`: 用户CPU时间(秒)
- `%S`: 系统CPU时间(秒)
- `%P`: CPU百分比((%U + %S) / %E)
- `%M`: 最大常驻集大小(KB)
- `%x`: 退出状态

`time`命令对于性能分析和基准测试非常有用，可以帮助你了解命令的资源消耗情况。

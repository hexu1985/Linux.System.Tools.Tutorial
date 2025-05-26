# slabtop 命令用法及输出说明

`slabtop` 是一个用于实时显示内核 slab 内存缓存信息的命令行工具，类似于 `top` 命令，但专门用于显示 slab 分配器的情况。

## 基本用法

```bash
slabtop [选项]
```

### 常用选项

- `-d N` 或 `--delay=N`：设置刷新间隔时间（秒），默认 3 秒
- `-s S` 或 `--sort=S`：按指定列排序（c:缓存大小，l:对象数量，o:对象大小，n:名称，p:每slab页数，等等）
- `-o` 或 `--once`：只显示一次然后退出
- `-V` 或 `--version`：显示版本信息
- `-h` 或 `--help`：显示帮助信息

## 输出说明

`slabtop` 的输出通常包含以下列：

```
 Active / Total Objects (% used)    : 123456 / 234567 (52.3%)
 Active / Total Slabs (% used)      : 7890 / 12345 (63.9%)
 Active / Total Caches (% used)     : 123 / 234 (52.6%)
 Active / Total Size (% used)       : 123.45MB / 234.56MB (52.7%)
 Minimum / Average / Maximum Object : 0.01K / 0.12K / 128.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
 12345  12345 100%    0.12K    123      100     12.3K dentry
  6789   5678  83%    1.00K     89       64     89.0K ext4_inode_cache
  ...
```

### 各列含义

1. **顶部汇总信息**：
   - `Active / Total Objects`：活跃对象数/总对象数（使用百分比）
   - `Active / Total Slabs`：活跃slab数/总slab数（使用百分比）
   - `Active / Total Caches`：活跃缓存数/总缓存数（使用百分比）
   - `Active / Total Size`：活跃内存大小/总内存大小（使用百分比）
   - `Minimum / Average / Maximum Object`：最小/平均/最大对象大小

2. **详细列表各列**：
   - `OBJS`：该缓存中的对象总数
   - `ACTIVE`：活跃对象数
   - `USE`：活跃对象百分比
   - `OBJ SIZE`：单个对象大小（KB）
   - `SLABS`：使用的slab数量
   - `OBJ/SLAB`：每个slab中的对象数
   - `CACHE SIZE`：该缓存占用的总内存大小（KB）
   - `NAME`：缓存名称

## 使用示例

1. 默认显示（每3秒刷新一次）：
   ```bash
   slabtop
   ```

2. 按缓存大小排序：
   ```bash
   slabtop -s c
   ```

3. 只显示一次输出：
   ```bash
   slabtop -o
   ```

4. 每5秒刷新一次，并按对象数量排序：
   ```bash
   slabtop -d 5 -s l
   ```

## 实际应用

`slabtop` 可用于：
- 诊断内核内存泄漏问题
- 监控内核内存使用情况
- 识别占用内存较多的内核缓存
- 了解系统内核对象分配情况

通过观察 `dentry`、`inode_cache` 等缓存的使用情况，可以了解文件系统相关的内存使用状况。

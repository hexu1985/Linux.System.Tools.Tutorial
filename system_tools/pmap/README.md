# pmap 命令用法及输出说明

`pmap` 是 Linux 系统中用于显示进程内存映射情况的工具，它可以显示一个或多个进程的内存使用情况。

## 基本用法

```bash
pmap [选项] 进程ID [进程ID...]
```

## 常用选项

- `-x`：显示扩展格式，包含更多详细信息
- `-d`：显示设备格式
- `-q`：安静模式，不显示头尾信息
- `-p`：显示完整路径
- `-V`：显示版本信息

## 输出说明（以 `pmap -x` 为例）

```
Address           Kbytes     RSS   Dirty Mode  Mapping
0000555555554000       4       4       0 r-x-- a.out
0000555555755000       4       4       4 r---- a.out
0000555555756000       4       4       4 rw--- a.out
00007ffff7a3e000    1804     300       0 r-x-- libc-2.27.so
00007ffff7bfb000    2048       0       0 ----- libc-2.27.so
00007ffff7dfb000      16      16      16 r---- libc-2.27.so
00007ffff7dff000       8       8       8 rw--- libc-2.27.so
...
total kB           123456   78901   12345
```

各列含义：

1. **Address**：内存区域的起始地址
2. **Kbytes**：该内存区域的大小（KB）
3. **RSS**：常驻内存集大小（实际使用的物理内存，KB）
4. **Dirty**：脏页大小（被修改过的内存，KB）
5. **Mode**：内存权限（r=读，w=写，x=执行，s=共享，p=私有）
6. **Mapping**：内存映射的文件或类型

最后一行是汇总信息：
- **total kB**：进程使用的总虚拟内存、物理内存和脏页大小

## 实际应用示例

1. 查看进程1234的内存使用情况：
   ```bash
   pmap 1234
   ```

2. 查看详细内存信息：
   ```bash
   pmap -x 1234
   ```

3. 查看多个进程的内存信息：
   ```bash
   pmap 1234 5678
   ```

4. 结合grep查找特定库的内存使用：
   ```bash
   pmap 1234 | grep libc
   ```

## 注意事项

- 需要足够的权限才能查看其他用户进程的内存信息
- RSS列显示的是实际使用的物理内存，这是评估进程内存占用的重要指标
- 共享库的内存会被多个进程共享，因此所有进程的RSS总和可能大于系统实际使用的物理内存

# Google Perftools 生成火焰图示例

下面是一个使用 Google Perftools (gperftools) 生成火焰图的完整示例流程：

## 1. 安装必要工具

```bash
# 安装 gperftools
sudo apt-get install google-perftools libgoogle-perftools-dev  # Ubuntu/Debian
# 或
sudo yum install gperftools gperftools-devel           # CentOS/RHEL

# 安装火焰图生成工具
git clone https://github.com/brendangregg/FlameGraph.git
export PATH=$PATH:$(pwd)/FlameGraph
```

## 2. 示例程序准备

创建一个简单的 C++ 示例程序 `example.cpp`：

```cpp
#include <iostream>
#include <vector>
#include <cmath>

void busyFunction() {
    for (int i = 0; i < 1000000; ++i) {
        std::vector<double> v;
        for (int j = 0; j < 100; ++j) {
            v.push_back(std::sin(j) * std::cos(i));
        }
    }
}

void anotherFunction() {
    for (int i = 0; i < 500; ++i) {
        busyFunction();
    }
}

int main() {
    std::cout << "Profiling example started..." << std::endl;
    for (int i = 0; i < 5; ++i) {
        anotherFunction();
        busyFunction();
    }
    std::cout << "Profiling example finished." << std::endl;
    return 0;
}
```

## 3. 编译程序并链接 profiler

```bash
g++ -std=c++11 -g -O0 example.cpp -o example -lprofiler
```

## 4. 运行程序并生成性能数据

```bash
# 设置环境变量并运行程序
CPUPROFILE=prof.out ./example
```

这将生成 `prof.out` 性能分析文件。

## 5. 将输出转换为火焰图格式

```bash
# 使用 pprof 工具生成火焰图数据
pprof --collapsed ./example prof.out > prof.collapsed
```

## 6. 生成火焰图

```bash
# 使用 FlameGraph 脚本生成 SVG 火焰图
flamegraph.pl prof.collapsed > flamegraph.svg
```

## 7. 查看火焰图

用浏览器打开生成的 `flamegraph.svg` 文件，你将看到类似如下的可视化结果：

- 底部是 `main` 函数
- 上面是 `main` 调用的函数
- 宽度表示函数占用 CPU 时间的比例
- 可以交互式地点击查看详细信息

## 进阶选项

1. **实时分析**：
   ```bash
   CPUPROFILE=prof.out CPUPROFILE_FREQUENCY=1000 ./example
   ```

2. **文本分析报告**：
   ```bash
   pprof --text ./example prof.out
   ```

3. **图形化调用图**：
   ```bash
   pprof --pdf ./example prof.out > output.pdf
   ```

4. **多线程分析**：
   ```bash
   CPUPROFILE=prof.out CPUPROFILE_REALTIME=1 ./example
   ```

注意：火焰图最适合查看 CPU 时间的热点分布，对于其他类型的分析（如内存），可能需要使用不同的工具和方法。

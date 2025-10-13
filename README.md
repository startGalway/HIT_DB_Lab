# HIT_DB_Lab
哈工大数据库系统实验 (Harbin Institute of Technology Database Systems Lab)

## 概述 (Overview)

本项目为哈工大数据库系统实验环境，基于RUC数据库实验平台。

This project provides the laboratory environment for HIT Database Systems course, based on the RUC database lab platform.

## 系统要求 (System Requirements)

- Ubuntu/Debian Linux 系统
- CMake 3.10 或更高版本
- GCC 编译器
- Git

## 快速开始 (Quick Start)

### 自动安装 (Automated Setup)

运行以下命令进行一键安装：

```bash
./setup.sh
```

### 手动安装 (Manual Setup)

如果您希望手动安装，请按照以下步骤：

1. **安装系统依赖** (Install System Dependencies):
```bash
sudo apt-get update
sudo apt-get install flex bison libreadline-dev cmake build-essential git
```

2. **创建实验目录** (Create Lab Directory):
```bash
mkdir rucbase-lab
cd rucbase-lab
```

3. **克隆实验代码** (Clone Lab Code):
```bash
git clone --recursive https://gitee.com/HIT-DB/hit-db-class-rucbase-lab.git .
```

4. **构建Google Test** (Build Google Test):
```bash
cd deps/googletest
git submodule init
git submodule update
mkdir build
cd build
cmake ..
make
sudo make install
```

5. **返回实验根目录** (Return to Lab Root):
```bash
cd ../../..
```

## 项目结构 (Project Structure)

```
HIT_DB_Lab/
├── README.md           # 项目说明文档
├── setup.sh           # 自动安装脚本
└── rucbase-lab/       # 实验代码目录 (将被创建)
    ├── deps/          # 依赖库
    └── ...            # 其他实验文件
```

## 故障排除 (Troubleshooting)

### 常见问题 (Common Issues)

1. **权限错误**: 确保您有sudo权限来安装系统包
2. **网络问题**: 如果访问gitee.com有问题，请检查网络连接
3. **编译错误**: 确保安装了所有必需的开发工具

### 获取帮助 (Getting Help)

如果遇到问题，请检查：
- 系统是否满足要求
- 网络连接是否正常
- 是否有足够的磁盘空间

## 许可证 (License)

本项目遵循原始RUC实验平台的许可证条款。

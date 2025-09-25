# 安装指南 (Installation Guide)

## 前置要求 (Prerequisites)

在开始安装之前，请确保您的系统满足以下要求：

- **操作系统**: Ubuntu 18.04+ 或 Debian 10+
- **权限**: sudo 管理员权限
- **网络**: 可访问互联网（用于下载依赖包和实验代码）
- **存储空间**: 至少 2GB 可用空间

## 安装方法 (Installation Methods)

### 方法一：自动安装 (Method 1: Automated Installation)

**推荐方式 - 最简单快捷**

1. 克隆本仓库：
```bash
git clone https://github.com/startGalway/HIT_DB_Lab.git
cd HIT_DB_Lab
```

2. 运行自动安装脚本：
```bash
./setup.sh
```

安装脚本将自动完成以下操作：
- 检查系统环境
- 安装系统依赖包
- 创建实验目录
- 克隆实验代码
- 构建并安装Google Test

### 方法二：手动安装 (Method 2: Manual Installation)

如果您需要更多控制或自动脚本失败，可以按照以下步骤手动安装：

1. **更新系统包列表**：
```bash
sudo apt-get update
```

2. **安装系统依赖**：
```bash
sudo apt-get install flex bison libreadline-dev cmake build-essential git
```

3. **创建并进入实验目录**：
```bash
mkdir rucbase-lab
cd rucbase-lab
```

4. **克隆实验代码**：
```bash
git clone --recursive https://gitee.com/HIT-DB/hit-db-class-rucbase-lab.git .
```

5. **构建Google Test**：
```bash
cd deps/googletest
git submodule init
git submodule update
mkdir build
cd build
cmake ..
make
sudo make install
cd ../../..
```

## 验证安装 (Verify Installation)

安装完成后，您可以通过以下方式验证：

1. **检查实验目录**：
```bash
ls -la rucbase-lab/
```

2. **检查Google Test安装**：
```bash
ldconfig -p | grep gtest
```

3. **检查必要的系统工具**：
```bash
which flex bison cmake git
```

## 故障排除 (Troubleshooting)

### 常见问题解决方案

1. **权限错误**：
   - 确保您有sudo权限
   - 如果是共享系统，请联系系统管理员

2. **网络连接问题**：
   - 检查网络连接：`ping gitee.com`
   - 如果在企业网络，可能需要配置代理

3. **依赖包安装失败**：
   - 更新包列表：`sudo apt-get update`
   - 修复损坏的包：`sudo apt-get -f install`

4. **编译错误**：
   - 确保安装了完整的构建工具链
   - 检查磁盘空间是否充足

5. **Git子模块问题**：
   - 手动初始化子模块：`git submodule update --init --recursive`

### 获取帮助

如果遇到其他问题：
1. 查看安装日志中的错误信息
2. 确认系统满足所有前置要求
3. 尝试手动安装方法
4. 检查网络连接和防火墙设置

## 卸载 (Uninstallation)

如需卸载，可以删除相关目录：

```bash
# 删除实验目录
rm -rf rucbase-lab/

# 卸载Google Test（可选）
sudo rm -rf /usr/local/lib/libgtest*
sudo rm -rf /usr/local/include/gtest/
```

**注意**: 系统依赖包（flex, bison等）不会被自动卸载，因为它们可能被其他程序使用。
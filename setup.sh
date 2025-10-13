#!/bin/bash

# HIT Database Lab Setup Script
# 哈工大数据库系统实验环境安装脚本

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running on supported system
check_system() {
    print_status "检查系统环境... (Checking system environment...)"
    
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        print_error "此脚本仅支持Linux系统 (This script only supports Linux systems)"
        exit 1
    fi
    
    if ! command_exists apt-get; then
        print_error "需要apt包管理器 (apt package manager is required)"
        exit 1
    fi
    
    print_success "系统环境检查通过 (System environment check passed)"
}

# Install system dependencies
install_dependencies() {
    print_status "安装系统依赖... (Installing system dependencies...)"
    
    # Update package list
    print_status "更新包列表... (Updating package list...)"
    sudo apt-get update
    
    # Install required packages
    print_status "安装必需的包... (Installing required packages...)"
    sudo apt-get install -y flex bison libreadline-dev cmake build-essential git
    
    print_success "系统依赖安装完成 (System dependencies installed successfully)"
}

# Create lab directory and clone repository
setup_lab_environment() {
    print_status "设置实验环境... (Setting up lab environment...)"
    
    # Create rucbase-lab directory
    if [ -d "rucbase-lab" ]; then
        print_warning "rucbase-lab目录已存在，将跳过克隆步骤 (rucbase-lab directory exists, skipping clone)"
    else
        print_status "创建实验目录... (Creating lab directory...)"
        mkdir rucbase-lab
        
        print_status "克隆实验代码... (Cloning lab code...)"
        cd rucbase-lab
        
        # Clone the repository with recursive submodules
        if git clone --recursive https://gitee.com/HIT-DB/hit-db-class-rucbase-lab.git .; then
            print_success "实验代码克隆成功 (Lab code cloned successfully)"
        else
            print_error "克隆失败，请检查网络连接 (Clone failed, please check network connection)"
            exit 1
        fi
        
        cd ..
    fi
}

# Build and install Google Test
build_googletest() {
    print_status "构建Google Test... (Building Google Test...)"
    
    if [ ! -d "rucbase-lab/deps/googletest" ]; then
        print_error "Google Test目录不存在 (Google Test directory not found)"
        exit 1
    fi
    
    cd rucbase-lab/deps/googletest
    
    # Initialize and update submodules
    print_status "初始化子模块... (Initializing submodules...)"
    git submodule init
    git submodule update
    
    # Create build directory
    if [ ! -d "build" ]; then
        mkdir build
    fi
    
    cd build
    
    # Configure with CMake
    print_status "配置构建环境... (Configuring build environment...)"
    cmake ..
    
    # Build
    print_status "编译Google Test... (Compiling Google Test...)"
    make
    
    # Install
    print_status "安装Google Test... (Installing Google Test...)"
    sudo make install
    
    print_success "Google Test构建并安装成功 (Google Test built and installed successfully)"
    
    # Return to root directory
    cd ../../../..
}

# Verify installation
verify_installation() {
    print_status "验证安装... (Verifying installation...)"
    
    # Check if lab directory exists
    if [ -d "rucbase-lab" ]; then
        print_success "实验目录创建成功 (Lab directory created successfully)"
    else
        print_error "实验目录未找到 (Lab directory not found)"
        return 1
    fi
    
    # Check if Google Test is installed
    if ldconfig -p | grep -q gtest; then
        print_success "Google Test安装成功 (Google Test installed successfully)"
    else
        print_warning "Google Test可能未正确安装 (Google Test may not be properly installed)"
    fi
    
    # Check lab structure
    if [ -f "rucbase-lab/CMakeLists.txt" ] || [ -d "rucbase-lab/src" ]; then
        print_success "实验代码结构正常 (Lab code structure is normal)"
    else
        print_warning "实验代码结构可能不完整 (Lab code structure may be incomplete)"
    fi
}

# Main execution
main() {
    echo "=============================================="
    echo "HIT数据库系统实验环境安装脚本"
    echo "HIT Database Systems Lab Setup Script"
    echo "=============================================="
    echo
    
    check_system
    install_dependencies
    setup_lab_environment
    build_googletest
    verify_installation
    
    echo
    echo "=============================================="
    print_success "安装完成！(Installation completed!)"
    echo "=============================================="
    echo
    echo "下一步 (Next steps):"
    echo "1. cd rucbase-lab"
    echo "2. 查看实验文档 (Check lab documentation)"
    echo "3. 开始您的数据库实验 (Start your database lab)"
    echo
}

# Run main function
main "$@"
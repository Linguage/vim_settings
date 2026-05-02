#!/bin/bash

# cleanup.sh - 清理工作区中不需要的临时文件
# Author: vim-settings
# Date: 2025-06-17

set -e

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 统计
DELETED_FILES=0
TOTAL_SIZE=0

# 输出函数
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 删除文件并记录统计信息
remove_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local size=$(du -k "$file" | cut -f1)
        rm -f "$file"
        ((DELETED_FILES++))
        ((TOTAL_SIZE+=size))
        info "已删除: $file (${size}KB)"
    fi
}

# 显示帮助
show_help() {
    echo "用法: $0 [--force|--dry-run]"
    echo ""
    echo "选项:"
    echo "  --force    强制删除所有临时文件，不提示确认"
    echo "  --dry-run  只显示将要删除的文件，但不实际删除"
    echo "  --help     显示此帮助信息"
    echo ""
}

# 处理参数
FORCE=0
DRY_RUN=0

for arg in "$@"; do
    case $arg in
        --force)
            FORCE=1
            ;;
        --dry-run)
            DRY_RUN=1
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            warn "未知选项: $arg"
            show_help
            exit 1
            ;;
    esac
done

echo "====== Vim Settings 工作区清理 ======"
echo "开始清理临时文件..."

# 临时文件列表
TEMP_FILES=(
    # 诊断和测试文件
    "$SCRIPT_DIR/test_vim_modes.vim"
    
    # 潜在的备份文件
    "$SCRIPT_DIR/*.bak"
    "$SCRIPT_DIR/*.tmp"
    "$SCRIPT_DIR/*~"
    
    # 其他可能的临时文件
    "$SCRIPT_DIR/*.swp"
    "$SCRIPT_DIR/.*.swp"
)

if [ $DRY_RUN -eq 1 ]; then
    info "模拟运行模式 - 不会实际删除任何文件"
fi

# 清理文件
for pattern in "${TEMP_FILES[@]}"; do
    for file in $pattern; do
        if [ -f "$file" ]; then
            if [ $DRY_RUN -eq 1 ]; then
                info "将删除: $file"
            else
                remove_file "$file"
            fi
        fi
    done
done

# 清理空的临时文件夹
if [ $DRY_RUN -eq 0 ]; then
    EMPTY_DIRS=$(find "$SCRIPT_DIR" -type d -name "tmp*" -o -name "temp*" -o -name "*backup*" -o -name "*bak" -empty)
    if [ ! -z "$EMPTY_DIRS" ]; then
        for dir in $EMPTY_DIRS; do
            rmdir "$dir"
            info "已删除空文件夹: $dir"
        done
    fi
fi

# 确保保留的重要文件不被清理
PRESERVE_FILES=(
    "$SCRIPT_DIR/clean_empty_files.sh"
    "$SCRIPT_DIR/clean_empty_files_副本.sh"
    "$SCRIPT_DIR/cleanup.sh"
)

for file in "${PRESERVE_FILES[@]}"; do
    if [ -f "$file" ] && [ ! -x "$file" ]; then
        chmod +x "$file"
        info "已设置执行权限: $file"
    fi
done

# 输出结果
echo "====== 清理完成 ======"
if [ $DRY_RUN -eq 1 ]; then
    info "模拟运行完成，未执行实际删除"
else
    info "已清理 $DELETED_FILES 个临时文件，总计 ${TOTAL_SIZE}KB"
fi

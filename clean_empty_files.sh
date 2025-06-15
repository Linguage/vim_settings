#!/bin/bash

# Vim Settings - Clean Empty Files Script
# 一键清理文件夹下所有空文件的脚本
# Author: vim-settings
# Date: 2025-06-15

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo -e "${CYAN}Vim Settings - Clean Empty Files Script${NC}"
    echo ""
    echo -e "${YELLOW}用法:${NC}"
    echo "  $0 [OPTIONS] [DIRECTORY]"
    echo ""
    echo -e "${YELLOW}选项:${NC}"
    echo "  -h, --help          显示此帮助信息"
    echo "  -d, --dry-run       预览模式，只显示将要删除的文件，不实际删除"
    echo "  -r, --recursive     递归清理子目录（默认启用）"
    echo "  -i, --interactive   交互模式，每个文件删除前确认"
    echo "  -q, --quiet         静默模式，不显示详细输出"
    echo "  -v, --verbose       详细模式，显示更多信息"
    echo ""
    echo -e "${YELLOW}参数:${NC}"
    echo "  DIRECTORY           要清理的目录路径（默认为当前目录）"
    echo ""
    echo -e "${YELLOW}示例:${NC}"
    echo "  $0                  清理当前目录的空文件"
    echo "  $0 /path/to/dir     清理指定目录的空文件"
    echo "  $0 -d .             预览当前目录将要删除的空文件"
    echo "  $0 -i ~/Downloads   交互式清理下载目录的空文件"
    echo ""
    echo -e "${YELLOW}注意事项:${NC}"
    echo "  • 空文件定义：文件大小为 0 字节的普通文件"
    echo "  • 不会删除目录，即使目录为空"
    echo "  • 建议先使用 -d 选项预览要删除的文件"
    echo "  • 删除操作不可逆，请谨慎使用"
}

# 显示脚本信息
show_banner() {
    if [[ "$QUIET" != "true" ]]; then
        echo -e "${CYAN}=================================${NC}"
        echo -e "${CYAN}  Vim Settings - 空文件清理工具${NC}"
        echo -e "${CYAN}=================================${NC}"
        echo ""
    fi
}

# 日志函数
log_info() {
    if [[ "$QUIET" != "true" ]]; then
        echo -e "${GREEN}[INFO]${NC} $1"
    fi
}

log_warn() {
    if [[ "$QUIET" != "true" ]]; then
        echo -e "${YELLOW}[WARN]${NC} $1"
    fi
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_verbose() {
    if [[ "$VERBOSE" == "true" && "$QUIET" != "true" ]]; then
        echo -e "${BLUE}[VERBOSE]${NC} $1"
    fi
}

# 检查目录是否存在
check_directory() {
    local dir="$1"
    
    if [[ ! -d "$dir" ]]; then
        log_error "目录不存在: $dir"
        exit 1
    fi
    
    if [[ ! -r "$dir" ]]; then
        log_error "没有读取权限: $dir"
        exit 1
    fi
    
    log_verbose "目录检查通过: $dir"
}

# 查找空文件
find_empty_files() {
    local dir="$1"
    local recursive="$2"
    local print_null="$3"  # 是否使用 -print0
    
    log_verbose "开始查找空文件..."
    
    if [[ "$recursive" == "true" ]]; then
        if [[ "$print_null" == "-print0" ]]; then
            find "$dir" -type f -size 0 -print0 2>/dev/null
        else
            find "$dir" -type f -size 0 2>/dev/null
        fi
    else
        if [[ "$print_null" == "-print0" ]]; then
            find "$dir" -maxdepth 1 -type f -size 0 -print0 2>/dev/null
        else
            find "$dir" -maxdepth 1 -type f -size 0 2>/dev/null
        fi
    fi
}

# 确认删除
confirm_delete() {
    local file="$1"
    
    echo -e "${YELLOW}是否删除空文件: $file? [y/N]${NC}"
    read -r response
    case "$response" in
        [yY]|[yY][eE][sS])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# 删除空文件
delete_empty_files() {
    local dir="$1"
    local dry_run="$2"
    local interactive="$3"
    local recursive="$4"
    
    log_verbose "开始查找空文件..."
    
    # 使用数组存储文件列表，避免管道导致的变量作用域问题
    local empty_files_array=()
    while IFS= read -r -d '' file; do
        empty_files_array+=("$file")
    done < <(find_empty_files "$dir" "$recursive" -print0)
    
    if [[ ${#empty_files_array[@]} -eq 0 ]]; then
        log_info "未发现空文件"
        return 0
    fi
    
    local file_count=${#empty_files_array[@]}
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "预览模式 - 发现 $file_count 个空文件:"
        echo ""
        for file in "${empty_files_array[@]}"; do
            echo -e "${RED}[WILL DELETE]${NC} $file"
        done
        echo ""
        log_warn "以上文件将在实际运行时被删除"
        return 0
    fi
    
    log_info "发现 $file_count 个空文件"
    
    if [[ "$interactive" == "true" ]]; then
        log_info "交互模式 - 逐个确认删除"
        echo ""
    fi
    
    local deleted_count=0
    local skipped_count=0
    local failed_count=0
    
    for file in "${empty_files_array[@]}"; do
        if [[ -z "$file" ]]; then
            continue
        fi
        
        # 再次检查文件是否为空（防止在处理过程中文件被修改）
        if [[ ! -f "$file" ]]; then
            log_verbose "文件不存在，跳过: $file"
            ((skipped_count++))
            continue
        fi
        
        if [[ -s "$file" ]]; then
            log_verbose "文件不为空，跳过: $file"
            ((skipped_count++))
            continue
        fi
        
        # 交互模式确认
        if [[ "$interactive" == "true" ]]; then
            if ! confirm_delete "$file"; then
                log_verbose "用户取消删除: $file"
                ((skipped_count++))
                continue
            fi
        fi
        
        # 删除文件
        if rm -f "$file" 2>/dev/null; then
            log_verbose "已删除: $file"
            ((deleted_count++))
        else
            log_error "删除失败: $file"
            ((failed_count++))
        fi
    done
    
    echo ""
    # 显示统计结果
    if [[ $deleted_count -gt 0 ]]; then
        log_info "成功删除 $deleted_count 个空文件"
    fi
    
    if [[ $skipped_count -gt 0 ]]; then
        log_warn "跳过 $skipped_count 个文件"
    fi
    
    if [[ $failed_count -gt 0 ]]; then
        log_error "删除失败 $failed_count 个文件"
    fi
    
    if [[ $deleted_count -eq 0 && $skipped_count -eq 0 && $failed_count -eq 0 ]]; then
        log_info "没有需要处理的文件"
    fi
}

# 主函数
main() {
    local target_dir="."
    local dry_run="false"
    local interactive="false"
    local recursive="true"
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -d|--dry-run)
                dry_run="true"
                shift
                ;;
            -r|--recursive)
                recursive="true"
                shift
                ;;
            --no-recursive)
                recursive="false"
                shift
                ;;
            -i|--interactive)
                interactive="true"
                shift
                ;;
            -q|--quiet)
                QUIET="true"
                shift
                ;;
            -v|--verbose)
                VERBOSE="true"
                shift
                ;;
            -*)
                log_error "未知选项: $1"
                echo "使用 $0 --help 查看帮助信息"
                exit 1
                ;;
            *)
                target_dir="$1"
                shift
                ;;
        esac
    done
    
    # 显示横幅
    show_banner
    
    # 转换为绝对路径
    target_dir=$(cd "$target_dir" && pwd)
    
    log_info "目标目录: $target_dir"
    
    # 检查目录
    check_directory "$target_dir"
    
    # 执行清理
    delete_empty_files "$target_dir" "$dry_run" "$interactive" "$recursive"
    
    if [[ "$QUIET" != "true" ]]; then
        echo ""
        log_info "清理完成!"
    fi
}

# 脚本入口
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

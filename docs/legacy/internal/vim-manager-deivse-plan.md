# vim-manager 修改与重构计划

> 导航：本篇在 [docs/INDEX.md](../../INDEX.md) 中标为历史计划稿；实现状态以仓库内脚本与 changelog 为准。

## 第一阶段：清理与调整 `vim-manager` 脚本

**目标：** 根据奥卡姆剃刀原则，移除冗余功能，保留核心配置管理能力，确保脚本与当前项目设置一致。

**步骤：**

1. **备份原始 `vim-manager` 文件**:
  - 在进行任何修改之前，创建 `vim-manager` 脚本的备份，例如 `vim-manager.bak`。
2. **移除主题管理相关功能**:
  - 删除以下函数定义：
    - `manage_themes`
    - `install_themes`
    - `create_theme_switcher`
    - `list_themes`
    - `show_current_theme`
    - `switch_theme_cli`
    - `set_theme`
  - 从 `main` 函数的 `case` 语句中移除对 `manage_themes` 或其子命令的调用。
3. **移除新版/扩展插件管理功能**:
  - 删除以下函数定义：
    - `manage_plugins`
    - `list_plugins` (在 `manage_plugins` 内部调用的版本)
    - `update_plugins` (在 `manage_plugins` 内部调用的版本)
    - 确保 `add_plugin`, `remove_plugin`, `clean_plugins` (如果存在空定义或引用) 被移除。
  - 从 `main` 函数的 `case` 语句中移除对 `manage_plugins` 或其子命令的调用。
4. **移除环境检测与安装模块**:
  - 删除以下函数定义：
    - `detect_environment`
    - `install_environment`
    - `install_basic`
    - `install_complete`
    - `install_macvim`
    - `install_basic_plugins`
    - `install_all_plugins`
    - `install_fonts`
  - 从 `main` 函数的 `case` 语句中移除对这些功能的调用（如果存在）。
5. **移除冗余的 `link_config` 定义**:
  - 定位并删除脚本中第二个（通常在较后位置）`link_config` 函数的定义。
  - 确保保留脚本最开始定义的核心 `link_config` 函数。
6. **移除 `start_macvim` 功能 (可选，根据需求)**:
  - 删除 `start_macvim` 函数定义。
  - 从 `main` 函数的 `case` 语句中移除对 `start_macvim` 的调用。
7. **移除冗余的 `check_status` 功能**:
  - 删除 `check_status` 函数定义 (通常是较后定义的那个，与 `detect_environment` 相关的版本)。
  - 确保保留核心的 `do_status` 函数。
8. **审查并更新核心 `PLUGINS` 数组**:
  - 仔细核对 `PLUGINS` 数组中的每个条目。
  - 确保每个插件的 Git URL 和本地目录名与 `/Users/henri/Documents/vim_settings/plugins/` 目录下的实际情况完全一致。
  - 添加缺失的插件，移除项目中已不存在但仍在数组中的插件。
9. **调整 `main` 函数**:
  - 检查 `main` 函数中的 `case` 语句。
  - 确保只保留对以下核心功能的调用：
    - `do_install` (调用 `install`)
    - `do_update` (调用 `update`)
    - `do_clean` (调用 `clean`)
    - `do_status` (调用 `status`)
    - `do_uninstall` (调用 `uninstall`)
    - `show_help` (调用 `help` 或作为默认/无效命令的处理)
  - 移除所有对已删除函数的引用。
10. **测试脚本**:
  - 在清理和调整后，对 `vim-manager` 的核心命令 (`install`, `update`, `clean`, `status`, `uninstall`, `help`) 进行基本测试，确保它们按预期工作。

## 第二阶段：将 `vim-manager` 拆分为多文件模块

**目标：** 提高代码的可维护性和组织性，将单一的 `vim-manager` 脚本拆分为多个逻辑相关的模块化文件。

**步骤：**

1. **创建新的模块目录**:
  - 在 `/Users/henri/Documents/vim_settings/` 目录下创建一个新的文件夹，用于存放拆分后的模块文件，例如 `vim_manager_modules`。
2. **规划模块划分**:
  - 根据清理后的 `vim-manager` 脚本的功能，规划如何将其拆分为不同的文件。可能的模块包括：
    - `config.sh`: 存放全局配置变量 (如 `SCRIPT_DIR`, `PLUGINS_DIR`, `PLUGINS` 数组, 颜色代码)。
    - `helpers.sh`: 存放辅助函数 (如 `success`, `warning`, `error`, `info`, `header`, `command_exists`)。
    - `core_logic.sh`: 存放核心操作函数 (如 `link_config`, `install_plugins`)。
    - `commands.sh`: 存放主要的命令处理函数 (如 `do_install`, `do_update`, `do_clean`, `do_status`, `do_uninstall`, `show_help`)。
    - `main.sh` (或者修改原 `vim-manager` 作为主入口): 包含主执行逻辑 (`main` 函数)，并负责 `source` 其他模块文件。
3. **拆分脚本到模块文件**:
  - 将 `vim-manager` 中的相应代码块剪切并粘贴到新创建的模块文件中。
  - 确保每个模块文件都是可执行的 (如果需要单独测试) 或被正确 `source`。
4. **处理依赖和 sourcing**:
  - 在主入口文件 (`main.sh` 或调整后的 `vim-manager`) 的开头，使用 `source` 命令引入其他模块文件。
    - 例如: `source ./vim_manager_modules/config.sh`
    - 注意路径的正确性。
  - 确保函数和变量在被调用的模块中是可见的。Bash 函数默认是全局的，但变量作用域需要注意。
5. **调整主入口脚本 (`vim-manager`)**:
  - 如果选择保留 `vim-manager` 作为主入口，清空其原有内容，只保留 `source` 各模块文件和调用 `main` 函数的逻辑。
  - 确保脚本的 shebang (`#!/bin/bash`) 依然存在于主入口文件。
6. **更新文件权限**:
  - 确保主入口脚本 (`vim-manager`) 具有执行权限 (`chmod +x vim-manager`)。
7. **全面测试**:
  - 在拆分完成后，对所有命令进行彻底测试，确保功能与拆分前一致，并且没有因文件拆分引入路径或作用域问题。
  - 测试各种使用场景和边缘情况。
8. **文档更新 (可选但推荐)**:
    *   如果需要，更新 `docs/legacy/internal/vim-manager-docs.md` 或其他相关文档，以反映新的多文件模块结构和使用方法。

## 完成状态

### 第一阶段：清理与调整 `vim-manager` 脚本 ✅ 已完成

**完成的工作：**

1. ✅ **备份原始文件**: 创建了 `vim-manager.bak` 备份文件
2. ✅ **移除主题管理功能**: 删除了所有主题相关函数 (`manage_themes`, `install_themes`, `create_theme_switcher`, `list_themes`, `show_current_theme`, `switch_theme_cli`, `set_theme`)
3. ✅ **移除新版插件管理功能**: 删除了 `manage_plugins`, `list_plugins`, `update_plugins` 等新版插件管理函数
4. ✅ **移除环境检测与安装模块**: 删除了 `detect_environment`, `install_environment`, `install_basic`, `install_complete`, `install_macvim`, `install_basic_plugins`, `install_all_plugins`, `install_fonts` 等函数
5. ✅ **移除冗余的 `link_config` 定义**: 删除了第二个 `link_config` 函数定义
6. ✅ **移除 `start_macvim` 功能**: 删除了 MacVim 启动功能
7. ✅ **移除冗余的 `check_status` 功能**: 删除了新版的 `check_status` 函数，保留核心的 `do_status`
8. ✅ **更新核心 `PLUGINS` 数组**: 更新了插件列表以匹配当前项目结构，包括所有 12 个实际存在的插件
9. ✅ **调整 `main` 函数**: 确保只调用核心功能 (`install`, `update`, `clean`, `status`, `uninstall`, `help`)
10. ✅ **测试脚本**: 验证了所有核心命令正常工作

### 第二阶段：将 `vim-manager` 拆分为多文件模块 ✅ 已完成

**完成的工作：**

1. ✅ **创建模块目录**: 创建了 `vim_manager_modules/` 目录
2. ✅ **拆分为模块文件**:
  - `config.sh`: 全局配置变量、插件数组、颜色代码
  - `helpers.sh`: 辅助函数 (`success`, `warning`, `error`, `info`, `header`, `command_exists`)
  - `core_logic.sh`: 核心操作函数 (`link_config`, `install_plugins`)
  - `commands.sh`: 命令处理函数 (`show_help`, `do_install`, `do_update`, `do_clean`, `do_status`, `do_uninstall`)
3. ✅ **创建新的主入口脚本**: 重写 `vim-manager` 为模块化入口，使用 `source` 引入各模块
4. ✅ **处理依赖和 sourcing**: 正确设置模块间的依赖关系和变量作用域
5. ✅ **更新文件权限**: 确保主入口脚本具有执行权限
6. ✅ **全面测试**: 验证模块化后的脚本功能与原版一致

**测试结果：**

- ✅ `./vim-manager help` - 显示帮助信息
- ✅ `./vim-manager status` - 正确检查配置和插件状态
- ✅ 所有核心命令 (`install`, `update`, `clean`, `status`, `uninstall`) 均可正常使用

**清理效果：**

- 原脚本行数：1075 行 → 清理后：396 行 → 模块化后：主文件仅 35 行
- 移除了约 679 行冗余代码（63% 的代码减少）
- 提高了代码的可维护性和组织性
- 保留了所有核心功能，符合奥卡姆剃刀原则

**文件结构：**

```
vim-manager (35 行 - 主入口)
vim_manager_modules/
├── config.sh (33 行 - 配置)
├── helpers.sh (12 行 - 工具函数)  
├── core_logic.sh (89 行 - 核心逻辑)
└── commands.sh (227 行 - 命令处理)
```

## 总结

根据奥卡姆剃刀原则，成功将 `vim-manager` 从一个包含大量冗余功能的 1075 行单文件脚本，重构为一个清洁、模块化、专注于核心功能的多文件系统。新系统保持了所有必要的插件管理功能，同时提高了代码的可读性和可维护性。
# GitHub Copilot 快速开始指南

## 🤖 GitHub Copilot 已集成到您的 Vim 配置中

GitHub Copilot 是一个AI编程助手，可以根据您的代码上下文提供智能建议。

## 📋 前置要求

1. **GitHub Copilot 订阅** - 确保您有活跃的 GitHub Copilot 订阅
2. **Node.js** - 已安装 ✅
3. **Vim 9.0.0185+** - 您的版本：9.1 ✅

## 🚀 首次设置

1. **启动 vim**：
   ```bash
   vim
   ```

2. **运行 Copilot 设置**：
   ```vim
   :Copilot setup
   ```

3. **按照提示操作**：
   - 浏览器会打开 GitHub 设备激活页面
   - 复制显示的设备代码
   - 在浏览器中输入代码并授权

## ⌨️ 快捷键

### Copilot 建议控制
- `Ctrl+G` - 接受当前建议
- `Ctrl+]` - 查看下一个建议
- `Ctrl+[` - 查看上一个建议
- `Ctrl+\` - 忽略当前建议

### 退出插入模式（已优化）
- `ESC` - 标准退出方式
- `Ctrl+C` - vim 默认退出方式
- `jk` 或 `kj` - 快速退出（新增）

## 📝 常用命令

- `:Copilot status` - 查看 Copilot 状态
- `:Copilot enable` - 启用 Copilot
- `:Copilot disable` - 暂时禁用 Copilot
- `:Copilot setup` - 重新设置认证

## 💡 使用技巧

1. **写注释描述需求**：Copilot 会根据注释生成代码
   ```python
   # 创建一个函数来计算两个数的最大公约数
   ```

2. **函数签名**：定义函数名和参数，Copilot 会补全实现
   ```javascript
   function fibonacci(n) {
       // Copilot 会建议实现
   ```

3. **上下文理解**：Copilot 会分析整个文件的上下文来提供更准确的建议

## 🔧 文件类型支持

默认配置支持以下文件类型：
- ✅ Python, JavaScript, TypeScript
- ✅ HTML, CSS, JSON
- ✅ Markdown, YAML
- ❌ Git 提交信息（已禁用）

## 🆘 故障排除

### 如果 Copilot 不工作：
1. 检查状态：`:Copilot status`
2. 重新认证：`:Copilot setup`
3. 检查网络连接
4. 确认订阅状态

### 如果快捷键冲突：
所有快捷键都已经过优化，避免与现有配置冲突。如需自定义，请编辑 `settings/plugin_configs.vim`。

## 📚 更多信息

- [快捷键完整列表](keybindings.zh.md)
- [GitHub Copilot 官方文档](https://docs.github.com/en/copilot)
- [插件源码](https://github.com/github/copilot.vim)

现在您可以开始享受 AI 辅助编程的体验了！🎉

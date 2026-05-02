# reports 索引

本目录存放**沉淀出来的经验内容**：阶段分析、专项复盘、跨任务教训、可复用决策证据。与 `work-notes/` 的核心区别：

- `work-notes/` 是**经历**：按时间推进的研发记录，描述发生了什么。
- `reports/` 是**经验**：从经历中提炼后仍服务当前决策、实现理解或专题结论的内容。

只有仍然服务当前判断的问题，才应放在“当前优先阅读”区域。

## 当前优先阅读

- [LazyVim 参考借鉴分析](lazyvim-reference-analysis.md)：对照当前 Vim 配置与本地 LazyVim 笔记，整理可迁移的按键、检索、文件树和 which-key 工作流。
- [spf13-vim 参考借鉴分析](spf13-vim-reference-analysis.md)：对照经典 Vim 分发版，整理本地覆盖层级、功能开关、状态目录、经典映射与插件候选。

## 专题经验沉淀

- [LazyVim 参考借鉴分析](lazyvim-reference-analysis.md)：结论是优先借鉴工作流组织与按键分组，不直接迁移 Neovim/Lua 插件体系。
- [spf13-vim 参考借鉴分析](spf13-vim-reference-analysis.md)：结论是吸收成熟治理经验和小而稳的经典插件，不迁移 Vundle 与旧补全栈。

## 使用建议

1. 新增报告时在此索引中添加条目。
2. 标注「当前优先阅读」帮助新读者快速定位。
3. 想追踪当前做什么，不看 reports，转去 `../specs/ROADMAP.md` 与 `../jobs/README.md`。
4. 内容如果只是“当时做了什么”，归 `../work-notes/`；如果已经提炼为可复用结论或可迁移原则，归本目录。

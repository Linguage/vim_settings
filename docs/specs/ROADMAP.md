# Vim 配置管理器 路线图 (Roadmap)

> 路线图文档：阶段路线与 todo-list，推动项目实施。
> 最近更新: 2026-05-02

---

## Phase 0: 脚手架搭建

- 引入 docs/specs 治理三件与 jobs/legacy/reports/work-notes 骨架
- 读者向：`docs/INDEX.md`（总索引；根目录仅存此文）；子目录含 `tutorials/`（上手与快捷键）、`legacy/`（含 changelog 与 `legacy/internal/` 归档）、`work-notes/` 等，与根 README、`c.md` 互链
- 在 `BLUEPRINT.md` / `ARCHITECTURE.md` 中补齐验收标准与技术决策占位内容

## Phase 1: 代码编辑 IDE 化升级

- 默认 profile 引入 Vim 原生 LSP、异步补全、诊断、格式化与测试入口。
- `minimal` profile 继续保持轻量编辑与检索，不要求 IDE 插件或语言服务器。
- 优先覆盖 Shell、Vimscript、JSON、YAML、Markdown 等通用脚本与配置文件编辑场景。
- 在制任务见 `docs/jobs/code-editing-ide-upgrade.md`。

---

## 相关导航

- 读者向索引：`docs/INDEX.md`
- 在制任务：`docs/jobs/`
- 历史归档：`docs/legacy/`
- 阶段报告：`docs/reports/`
- 工作日志：`docs/work-notes/`

---

*创建日期: 2026-05-02*

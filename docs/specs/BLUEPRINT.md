# Vim 配置管理器 项目蓝图 (Blueprint)

> 战略性文档：宏观规划与理念阐述。
> 最近更新: 2026-05-02

---

## 1. 项目定位

一个现代化、高度可定制的 Vim 配置仓库，附带 `vim-manager` 模块化 Shell 脚本，支持一键安装、更新、清理与卸载，便于跨设备维护与个人工作流演进。

## 2. 核心挑战与技术路线

{待补充 — 在项目推进中逐步填写}

## 3. 验收标准

{待补充}

## 4. 战略治理原则

1. **价值优先**：默认先交付可用配置与管理体验，再按需做结构性优化。
2. **证据驱动**：关键变更应有可复现的安装/冒烟步骤（如 `./vim-manager install` / `status`）。
3. **文档分层**：战略（Blueprint）、架构（Architecture）、路线（Roadmap）各司其职。
4. **一问一主文档**：同一个高频问题只保留一个主文档负责回答，避免并行维护多个真相源。
5. **Day 1 可归档**：明显会形成任务线、专题线或实验线的工作，从第一天开始保留入口、输出、摘要、验证和冻结条件。

## 5. 文档系统边界


| 文档                           | 职责                                |
| ---------------------------- | --------------------------------- |
| `docs/specs/BLUEPRINT.md`    | 战略层：宏观规划、理念、技术路线与验收标准             |
| `docs/specs/ARCHITECTURE.md` | 架构层：功能实现框架与关键技术细节                 |
| `docs/specs/ROADMAP.md`      | 执行层：阶段路线与 todo-list               |
| `docs/jobs/`                 | 在制专题文档                            |
| `docs/legacy/`               | 已完成任务归档                           |
| `docs/reports/`              | **经验沉淀**：阶段分析、专项复盘、可复用结论与决策证据     |
| `docs/work-notes/`           | **经历记录**：按时间推进的研发工作记录与 session 索引 |


`reports/` 与 `work-notes/` 的硬性边界：

- 只描述“当时做了什么”→ `work-notes/`
- 已经提炼为可复用结论、原则或专题决策证据 → `reports/`
- 在 work-notes 中发现某份记录被反复回看且实际承担了经验文档的职责，应主动迁入 reports，并保留迁移说明。

默认主文档分工：

- “读者向文档从哪进门”优先看 [docs/INDEX.md](../INDEX.md)
- “怎么运行/结果去哪”优先看 `c.md`
- “当前结构边界与目录语义”优先看 `docs/specs/ARCHITECTURE.md`
- “当前做什么/下一步做什么”优先看 `docs/specs/ROADMAP.md` 与 active `docs/jobs/`
- “历史材料如何回捞”优先看 `docs/legacy/`
- “经验沉淀与复盘结论”优先看 `docs/reports/INDEX.md`
- “研发过程的时间线记录”优先看 `docs/work-notes/INDEX.md`

**读者向专题文档**：统一在 [docs/INDEX.md](../INDEX.md) 登记；正文放在 `docs/tutorials/`（上手、快捷键）、`docs/legacy/`（含归档型 changelog 与 `legacy/internal/` 下的脚本分析/计划）、`docs/work-notes/` 等。**不在 `docs/` 根目录堆积独立 `.md`**。若某主题需要唯一真相源，应在 BLUEPRINT / ARCHITECTURE / ROADMAP 之一显式注明。
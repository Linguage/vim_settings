# Vim 配置管理器 项目约定

## 工具链

- **编辑器**：Vim
- **管理脚本**：Bash（`vim-manager` 与 `vim_manager_modules/`）
- **版本控制**：Git

## 语言与文档约定

本仓库的用户说明、README、以及 `docs/` 下面向使用者的 Markdown **仅使用简体中文**，不维护英文或其它语言的镜像文档（不要求与代码注释语言一致）。

## 项目结构

- `vimrc` + `settings/` + `colors/`：Vim 配置主体
- `vim-manager`、`vim_manager_modules/`：安装、更新、卸载等运维命令
- `scripts/`：`install_dependencies.sh`（依赖）、`bootstrap.sh`（deps+install）、`cleanup.sh`（清理临时文件）；与 `vim-manager deps` / `bootstrap` 协同
- `docs/specs/`：治理文档（BLUEPRINT / ARCHITECTURE / ROADMAP）
- `docs/jobs`、`docs/legacy`、`docs/reports`、`docs/work-notes`：任务与记录体系
- `docs/INDEX.md`：读者向文档总索引（**`docs/` 根目录只保留此文与固定子目录，不再放其它散落 `.md`**）
- `docs/tutorials/`：上手教程与快捷键一览（如 `tutorial.md`、`keybindings.md`）
- `docs/legacy/`：归档文档；当前含 **`changelog.md`**（更新日志）、**`internal/`**（`vim-manager` 旧版分析与重构计划等历史材料）；见 `legacy/README.md` 说明

## 文档系统协同（人 + AI）

### 核心三件（`docs/specs/`）

核心治理文档统一收敛在 `docs/specs/` 下；读者向内容由 `docs/INDEX.md` 导航：教程与快捷键在 **`docs/tutorials/`**，更新日志及脚本专题归档在 **`docs/legacy/`**（含 `legacy/internal/`），过程纪要在 **`docs/work-notes/`**，与 specs 并列。

1. `docs/specs/BLUEPRINT.md`：战略性文档，负责项目宏观规划与理念阐述。
2. `docs/specs/ARCHITECTURE.md`：实现框架文档，负责功能实现框架与技术细节说明。
3. `docs/specs/ROADMAP.md`：路线图文档，负责阶段路线与 todo-list 建议。

### 在制文档与归档

1. 进行中的专题/任务文档统一放在 `docs/jobs/`。
2. 每次任务推进后，及时更新 jobs 文档中的状态与下一步。
3. 任务完成后，将文档移动到 `docs/legacy/`。

### work-notes 与 reports 的边界

1. `docs/work-notes/` 只承载**经历**：按时间推进的研发工作记录，回答“当时做了什么”。
2. `docs/reports/` 承载**经验**：从经历中提炼出来、仍可指导当前决策或下一步实现的复盘、原则、专题结论。
3. 判别基准：如果文档主要是事件流水或阶段总结，归 work-notes；如果文档已经形成跨任务可复用的结论或可迁移原则，归 reports。
4. 反过来也成立：在 work-notes 中发现某段记录被反复回看且承担了“经验文档”的职责，应主动迁入 reports 并保留迁移说明。

### Day 1 可归档工作流

当 AI 新增或扩展一条任务线、专题线或实验线时，应尽早补齐以下最小声明：

1. `lifecycle`：`active patch` / `reference extension` / `experimental attempt`
2. `entrypoint`：唯一运行入口
3. `outputs`：固定输出目录或结果落点
4. `summary`：最小结果摘要落点
5. `smoke`：至少一个可复跑的最小验证命令
6. `freeze rule`：晋升、保留或冻结条件

### README 与操作清单分工

1. `README.md` 负责项目能力、框架与核心导航，不放过长指令列表。
2. 指令清单、目录索引、结果路径维护在根目录 `c.md`。

## AI 开发约束

在项目中新增或修改代码时，默认优先保证需求落地、可读性和回归稳定（安装/冒烟路径见 `c.md`）。

若某个子目录下存在更贴近上下文的 `Agents.md`，则在遵守本文件通用约束的同时，优先遵循该子目录的局部规则。
# Maintenance Guide

本文件面向维护者和 agent，不是普通用户使用说明。

## Authority hierarchy

本插件只有一套当前有效的 workflow authority。不要在多个文件中长期保留互相冲突的旧版本规则。

- plugin.json：包身份与 OpenAI 安装界面 metadata。
- .agents/plugins/marketplace.json：repo marketplace 发现/安装配置。
- skills/content-ppt/SKILL.md：发现触发、常驻动作语义、动作边界、动作 -> reference 路由、少量全局硬约束。
- skills/content-ppt/references/workflow.md：业务流程 authority。
- skills/content-ppt/references/image-handoff.md：图片检查与 Imagegen handoff 技巧 authority。
- skills/content-ppt/references/ppt-authoring.md：可编辑 PowerPoint 制作技巧 authority。
- README.md：中文用户文档。

不要把详细 CCM 文件传输步骤复制到 workflow.md；不要把 PPT 原生对象实现细节复制到 image-handoff.md。

## Scope

插件定位是 content-first / evidence-heavy PPT workflow，覆盖科研、课程、工程、技术、项目、设计评审等。

不要把 skill description 扩大成“所有 PPT 请求都必须触发”。纯品牌、营销、海报式视觉美化不是主要目标。

## Action routing

动作是 SKILL.md 中的分类法，不是持久状态。

不要创建 ppt_pipeline_state.md、operation 状态文件或其它运行状态镜像。

每轮根据最新用户要求和当前工件判断动作。一个动作可以加载多个 references，同一个 reference 可以被多个动作复用。

## Reference availability

不要为了验证 reference 还在不在上下文而主动重读。

优先复用当前已经可直接执行的 authority。只有出现具体不足信号时才重读：

- 当前只剩摘要/转述；
- 上次读取明确被截断；
- 当前动作需要的关键规则无法恢复；
- 可用规则明显部分或互相冲突。

“不确定是否逐字和源文件一致”不是重读理由。

reference 可以保持稳定标题、版本或边界 marker 作为辅助，但不要设计成每轮强制核验 marker。

## Change discipline

修改核心规则时：

1. 先确定 owning file。
2. 修改 owning file。
3. 检查 SKILL.md 的短版 invariant / routing 是否需要同步。
4. 检查 README 是否存在面向用户的行为变化。
5. 检查 marketplace / manifest metadata 是否需要同步。
6. 搜索被新结论替代的旧术语和旧规则，删除或改写，不要并列保留历史方案。

Mode 名称统一使用：

- Imagegen-assisted
- Native-editable

不要重新引入 Mode A / Mode B 作为用户可见主名称。

## Release checks

发布前至少检查：

- plugin.json 是合法 portable manifest，根 schema 与当前 Agent Plugins 版本一致；
- skill 目录名与 SKILL.md frontmatter name 一致；
- README 安装步骤与当前 OpenAI repo marketplace 文档一致；
- SKILL.md 足够短，不塞入完整 workflow；
- 三个 references 没有职责漂移；
- handoff 仍要求实际查看参考图、实际发送文件、同轮完整 prompt；
- Native-editable 仍要求最终零 Imagegen 残留；
- authority-availability 仍是“优先复用，明确不足才重读”；
- source / image / data 不得凭文件名或搜索摘要臆测；
- whole-deck final review gate 没有被删掉。
- `plugin.json` 和 `.agents/plugins/marketplace.json` 必须保存为 UTF-8 **无 BOM**；当前 Codex CLI 的 marketplace JSON 解析会拒绝 UTF-8 BOM。
- 面向当前 ChatGPT “新插件 -> 上传 ZIP”界面的交付包默认使用最严格兼容布局：ZIP 根目录直接放 `plugin.json` + `skills/`，不套外层插件目录，也不包含 repo marketplace 的 `.agents/plugins/marketplace.json`、README 或 AGENTS。
- 生成 ChatGPT 上传包时优先运行 scripts/build-chatgpt-zip.ps1，不要手工选择文件打包；脚本输出目录 dist/ 不进入 Git。

## Versioning

使用 Semantic Versioning：

- patch：文字澄清、bugfix、规则修正，不改变兼容行为；
- minor：向后兼容的新动作、场景或 reference 能力；
- major：触发范围、核心工作流、文件结构或关键 hard gate 的不兼容变化。

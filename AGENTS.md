# Maintenance Guide

本文件面向维护者和 agent，不是普通用户使用说明。

## Authority hierarchy

本插件只有一套当前有效 workflow authority。被新规则替代的旧流程必须删除或改写，不保留历史兼容分支、deprecated 别名或防御性旧说明。

- plugin.json：插件身份与 OpenAI 安装 metadata；
- .agents/plugins/marketplace.json：repo marketplace 发现/安装配置；
- skills/content-ppt/SKILL.md：触发、动作语义、动作边界、动作到 reference 路由、少量全局硬约束；
- skills/content-ppt/references/workflow.md：业务流程 authority；
- skills/content-ppt/references/image-handoff.md：图片检查、生成材料包、交付面和 Imagegen 返工 mechanics；
- skills/content-ppt/references/ppt-authoring.md：可编辑 PowerPoint 制作与验证 authority；
- README.md：中文用户文档。

单个 PPT 项目的 README/protocol 是项目 overlay，不是第二套插件 workflow。优先级为：

1. 用户当前明确指令；
2. 项目 README/protocol + canonical 文件；
3. 本插件通用默认。

## Scope

插件定位为 content-first / evidence-heavy PPT workflow，覆盖科研、课程、工程、技术、项目、设计评审等。

不要把触发范围扩大成所有 PPT 请求。纯品牌、营销、海报式视觉美化不是主要目标。

## 当前生产模型

### 开始生成

所选页面范围具备生成条件后，默认一次性准备并交付完整生成材料包。

正常用户生成包只能包含：

- 每页一个完整当前 TXT 提示词；
- 提示词实际需要的参考图片。

canonical Markdown 是内部 authority，不进入正常用户生成包，除非用户明确请求项目源文件。

默认把整包物化为一个经过校验的 ZIP，并完成真实交付。聊天交付使用 CCM send_file 或等价能力；夸克移动端流程上传同一个 ZIP。只生成本地 ZIP 不算完成交付。

### Imagegen 参考图

Imagegen 参考图只能使用实际图像格式，例如 PNG、JPG/JPEG、WebP。

PDF 不得直接交给 Imagegen。

PDF 来源必须先：

1. 提取实际需要的页/图；
2. 转换成图像；
3. 实际目视核对；
4. 检查内容、裁切、分辨率、可读性和科研含义；
5. 更新 canonical 和 prompt 中的文件名；
6. 再进入生成包。

### 可选夸克移动端交付

当 CCM + 夸克能力可用时，可推荐：

- TXT + 图片打 ZIP；
- CCM 上传夸克；
- 用户在夸克解压；
- 图片直接下载；
- TXT 打开后点右上角进入文档模式；
- 全选复制提示词；
- 到新的 GPT ImageGen 会话粘贴并上传该页图片。

这是可选便利方案，不是插件硬依赖。

## 持续项目状态

不要创建独立运行状态文件。

项目需要跨会话保存生产状态时，只允许维护两个当前值：

- 已生成进度；
- 连续已通过审核进度。

生产状态必须严格只有这两个值。生成物中间缺页由实际产物判断，不额外维护第三套交付进度或发送队列。

## 状态检查与审核

状态检查必须：

1. 读取项目明确指定的生成物来源；
2. 判断实际已生成页与缺页；
3. 从下一个未解决页按项目审核规则审核；
4. 更新已生成进度；
5. 更新连续已通过审核进度；
6. 报告未生成页和返工页。

状态检查或页面通过审核后，不自动继续发送新的页面材料。

只有以下情况重新交付材料：

- 用户明确要求；
- 返工需要；
- canonical 或素材发生变化；
- 已交付包缺失/损坏；
- delivery surface 发生变化；
- 项目协议明确要求。

如果页面历史上已经通过，但正式产物当前无法定位，记录为产物可用性问题；不要用 canonical 替代成品，也不要无依据撤销历史审核结论。

## Canonical discipline

- 长期、跨页规则和来源口径写项目 README/protocol；
- 单页内容、布局、素材角色和返修约束写对应 canonical spec；
- 用户反馈先写 canonical；
- 如果项目维护当前 TXT prompt，canonical 修改后同轮同步覆盖；
- 不保留 v2/final/revised 等平行 prompt 分叉，除非用户明确要求历史版本；
- README 不记录逐页踩坑流水账。

## Reference availability

不要为了证明 reference 仍在上下文而机械重读。

只有出现具体不足时才重读，例如：

- 当前只剩摘要或转述；
- 上次读取明确被截断；
- 当前动作需要的关键规则无法恢复；
- 当前 authority 明显部分或互相冲突。

## Change discipline

修改核心规则时：

1. 找到 owning file；
2. 修改 owning file；
3. 同步检查 SKILL.md 路由；
4. 同步检查 README 用户行为说明；
5. 检查 manifest / marketplace metadata；
6. 搜索被新结论替代的旧术语和旧规则；
7. 删除旧流程，不并列保留。

清理时以当前正向规则为准：整包开始生成、两项生产状态、审核不自动交付新材料、已交付未变化材料直接复用、用户包不含 canonical MD、Imagegen 参考图只使用图像文件。任何与这些规则冲突的旧语义直接删除，不保留兼容说明。

单页材料交付能力可以保留，但只用于用户明确请求单页材料或返工，不作为默认生产节奏。

## Encoding

项目文本使用 UTF-8。

Windows 或跨工具写入非 ASCII 文本后，必须实际读回抽查，拒绝：

- 连续问号占位
- replacement character；
- mojibake；
- 文件名或 prompt 引用损坏。

plugin.json 和 .agents/plugins/marketplace.json 必须 UTF-8 无 BOM。

## Release checks

发布前至少检查：

- plugin.json 是合法 portable manifest；
- skill 目录名与 SKILL.md frontmatter name 一致；
- SKILL.md 保持短，详细流程仍在 references；
- workflow.md、image-handoff.md、ppt-authoring.md 职责没有漂移；
- 开始生成默认整包交付；
- 正常用户生成包只有 TXT + PNG/JPG/JPEG/WebP；
- canonical MD 不在正常用户生成包；
- PDF 不可直接作为 Imagegen 参考图；
- PDF 转图要求仍包含实际目视核对；
- 只维护已生成 + 连续已通过审核两个进度；
- 生产状态严格只有两项；
- 页面通过或状态检查后没有自动继续发送新材料；
- 已交付整包可在内容未变化时复用；
- 返工仍 canonical-first，并给完整当前 prompt；
- GPT ImageGen 术语明确指 GPT / ChatGPT 原生图像生成；
- @图像生成 仍是可覆盖的目标会话推荐前缀；
- source / image / data 不得凭文件名或搜索摘要臆测；
- whole-deck final review gate 没有被删除；
- Native-editable 仍要求最终零 Imagegen 残留；
- authority availability 仍遵循“可复用则复用，明确不足才重读”；
- README 与当前行为一致；
- 仓库搜索没有残留旧流程 authority。

生成材料包使用 scripts/validate-generation-package.ps1 校验。

ChatGPT 插件上传包使用 scripts/build-chatgpt-zip.ps1 构建。插件 ZIP 和 PPT 生成材料 ZIP 是两类不同分发物，不要混用校验规则。

ChatGPT 插件 ZIP 根目录直接放 plugin.json + skills/，不包含 repo marketplace、README、AGENTS、scripts、.git、dist。

## Mode names

用户可见模式名称统一使用：

- Imagegen-assisted
- Native-editable

不要重新引入 Mode A / Mode B。

## Versioning

使用 Semantic Versioning：

- patch：文字澄清、bugfix、规则修正；
- minor：向后兼容的新动作、场景或 workflow 能力；
- major：触发范围、核心结构或关键 hard gate 的不兼容变化。

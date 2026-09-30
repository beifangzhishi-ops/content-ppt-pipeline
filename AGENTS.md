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

具体版式 example 不是 authority。`skills/content-ppt/references/examples/` 下的文件只在用户明确要求参考该案例/风格，或项目 README/protocol 明确选用时加载；其中的比例、配色、密度、小图并排和其它局部视觉规则不得反向升级成通用 hard rule。

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

## Material audit / evidence closure discipline

长项目的材料审核必须先锁定 narrative authority，再审局部新证据。

- narrative authority 负责章节/页面主线、实验分组、证据角色和“证据 → 结论”关系；
- 专项项目、新计算、补充实验、工作稿只在对应节点补充已完成并核实的数据、图、方法细节和边界；
- 更新时间更新不等于 authority 更高；用户明确指定的论文、报告、旧 deck 或 protocol 可以继续负责主线；
- 未完成计算、探索性重跑、仍需补实验的工作稿不得仅凭“更新”身份覆盖稳定主线；
- 正文与答疑/附录分角色：答疑可详细审计，但不得反向污染正文主线或把探索性结果升级成正式结论。

用户说“审材料”时，默认审核当前 canonical、prompt、证据/来源索引、源数据、派生图脚本、QA/生成脚本和当前状态文件；除非用户明确要求，不自动审核已生成页面图片，也不自动进入 Imagegen。

审核顺序固定为：

1. 页面/章节在 authoritative narrative 中的论证角色；
2. 实验、工况、数据集和证据—结论对应；
3. 实测 / 计算 / 拟合 / 预测 / verification / external validation / consistency check 等证据身份；
4. 单位、分母、样本数、事件数、统计定义、公式和关键数字；
5. 已完成的新证据如何补到既有主线；
6. 最后才是措辞、索引和低层整理。

“继续审 / 循环审”表示执行完整闭环：发现问题 → 回源核对 → 直接修项目文件 → 同步依赖 → QA → 再完整扫描。至少一整轮不再发现新的实质问题，才算材料收口。

### 一轮一个新会话

持续深审时，一个完整审核回合使用一个会话。该回合结束前把 durable state 全部写回项目文件；下一轮使用新会话，从 README / AGENTS / canonical / index / QA 重新进入。

- 不把长聊天当项目状态；
- README 只维护当前状态、authority/来源入口和必要项目说明；
- AGENTS 只维护可复用长期规则，不记本轮逐条发现或修复日志；
- 具体问题直接修进 canonical / prompt / index / source / script；
- 下一轮不要求回放上一轮聊天。

### 修生成源，不只修输出

如果错误会由 QA、索引生成器、prompt builder、派生图脚本或维护脚本重新产生，必须修改真正的生成源并重新生成依赖输出。失效的一次性/历史脚本如果还能把旧口径写回当前 canonical，应从当前维护面删除或明确退役，不能只靠“不要运行”维持安全。

QA 回归规则优先检查语义实质和证据锚点，不锁死固定句式，也不使用会误伤否定句、限定词或必要边界说明的机械禁词。QA 还应检查不可见控制字符、乱码、引用损坏等会逃过结构校验的文本问题。

## Data-figure discipline

- 有结构化原始数据或可靠 reconstruction chain 的 quantitative plot，优先程序化/可复现重绘；
- 同一项目、同一语义类别统一字体、轴、网格、线宽、marker、图例层级、数字格式和语义配色；
- 颜色保持语义稳定，但插件不硬编码全局 palette；
- 原始论文图、实验/显微图、不可可靠重建的正式图不为“统一画风”而篡改；
- quantitative plot 属于 evidence，不交给 Imagegen 伪造；
- 派生图记录来源数据和重建脚本/方法，并实际目视核对输出；
- 概念/关系图可以保留权威来源的科学关系而重新组织几何，不要求复制原图连线布局。

## Reuse / rebuild discipline

对已有 deck 做重排、顺延或局部改版时，先做逐页 disposition，再决定生成范围：

- 已通过且页面角色、核心内容、证据角色不变：reuse；
- 仅页码/章节位置变化：不自动 rebuild；
- 首版/当前生成未通过且没有后续通过版本：rebuild；
- 从未生成：new/generate；
- 页面角色、核心内容或证据发生实质变化：rebuild；
- 不再使用：retire。

`reuse / rebuild / new / retire` 可放项目 plan/index，但不是第三套全局生产进度。生成材料包只包含当前需要 new/rebuild 的页；可复用页不重复生成。

生成后审核必须实际看生成物，并同时对照当前 canonical、完整当前 prompt 和真实参考素材角色。失败后先修 authority，再生成下一版；新版本独立重新审核，旧失败原因只作为回归重点。

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

清理时以当前正向规则为准：整包开始生成、两项生产状态、审核不自动交付新材料、已交付未变化材料直接复用、用户包不含 canonical MD、Imagegen 参考图只使用图像文件、材料审核先锁 narrative authority、每个完整深审回合使用新会话、已有 deck 先做 reuse/rebuild 判定、quantitative plots 优先可复现重绘。任何与这些规则冲突的旧语义直接删除，不保留兼容说明。

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
- material audit 明确区分 narrative authority 与补充证据源；
- “审材料”不自动审核生成图或触发 Imagegen；
- 深度循环审核明确一个完整回合一个新会话，跨轮状态落项目文件；
- AGENTS 不记录逐轮审核日志，README 不记录逐页踩坑流水账；
- QA / prompt builder / index / plotting / maintenance scripts 不会把废弃口径重新写回 current canonical；
- QA 语义检查不依赖固定句式或机械禁词，并覆盖不可见控制字符；
- quantitative plots 有数据时优先可复现重绘，不由 Imagegen 伪造；
- 原始科研图不为风格统一而篡改；
- 已有 deck 的 reuse/rebuild/new/retire 判定不会新增第三套 production progress；
- generation package 只包含当前需要生成/重建的页，不重复打包可复用页；
- 中期答辩具体版式只存在于非权威 example，不进入通用 workflow hard rule；
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

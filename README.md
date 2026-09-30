# Content PPT Pipeline

面向科研、课程、工程、技术报告、项目评审等重内容场景的 PowerPoint 工作流插件。

核心目标：

- 内容与科研事实正确；
- 来源、图片和数据可追溯；
- 故事线和单页任务清楚；
- 信息密度适合正式汇报；
- Imagegen 生产材料可直接执行；
- 生成结果经过审核；
- Native-editable 模式最终保持 PowerPoint 原生可编辑；
- 整套交付前完成全局 QA。

纯品牌宣传、营销海报或只追求视觉装饰的 PPT，不是本插件的主要目标。

## 两种生产模式

### Imagegen-assisted

允许 GPT / ChatGPT 原生图像生成参与页面视觉生产。本项目统一称为 Imagegen；它不泛指第三方图像生成模型。

标准流程是：

1. 理解资料与证据；
2. 明确叙事 authority、补充证据源和长期来源入口；
3. 做材料挖掘与循环收口；
4. 校准版式和信息密度；
5. 建立逐页 canonical production spec；
6. 整包自审；
7. 对已有 deck 先判断哪些页复用、重建、新建或退役；
8. 在开始生成前，一次性准备并交付实际需要生成的页面材料包；
9. 用户基于该材料包生成页面；
10. 根据实际生成物检查进度并审核；
11. 需要返工的页面先更新 canonical / prompt，再重新生成并重新审核；
12. 完成整套 QA 和用户整套审核。

正常生成材料包只包含：

- 每页一个完整 TXT 提示词；
- 该提示词实际需要的参考图片。

canonical Markdown 是项目内部 authority，不放进正常用户生成包，除非用户明确要求项目源文件。

GPT ImageGen 的可复制提示词默认推荐首行使用 @图像生成，帮助目标 GPT 会话明确进入图像生成流程。它只是推荐值，可被用户或具体项目覆盖。

### Native-editable

最终交付以原生可编辑 PowerPoint 为准，不保留 Imagegen 生成像素或其它生成残留。

文字、公式、线条、箭头、结构、图表等优先使用 PowerPoint 原生对象；真实来源图片使用真实素材，数据图尽量从真实数据重绘。

## 材料审核与收口

长项目先明确“谁负责主线、谁负责补局部证据”。叙事 authority 决定章节/页面顺序、实验分组、证据角色和“证据 → 结论”关系；更新更晚的专项计算、补充实验或工作稿可以更新对应节点的数据、图和细节，但不能只因为更新时间更晚就重组整套叙事。

用户明确指定论文、报告、旧 deck 或 protocol 作为主参考时，以该指定为准。未完成计算、探索性重跑、仍需补实验的工作稿，不自动升级为正式证据。

“审材料”默认审核当前 canonical、prompt、证据/来源索引、源数据、派生图脚本、QA/生成脚本和项目当前状态文件；除非用户明确要求，不自动审核已生成页面图片，也不自动进入 Imagegen。

材料审核按“先主线、后局部”进行：

1. 每页/每章的论证角色；
2. 实验、工况、数据集和证据角色是否对应；
3. 实测 / 计算 / 拟合 / 预测 / verification / external validation / consistency check 等身份是否混淆；
4. 单位、分母、样本数、事件数、统计定义、公式和关键数字；
5. 已完成的新实验/新计算如何补到既有主线上；
6. 最后再处理措辞、索引和低层整理。

循环审核不是只汇报问题。每轮发现应直接落地到对应项目文件，再跑 QA 并重新扫描；至少一整轮没有新增实质问题，才算材料收口。

持续深审时，**一个完整审核回合使用一个新会话**。本轮把当前状态和修复写进项目文件后结束，下一轮从 README / AGENTS / canonical / index / QA 重新进入，避免单个会话不断膨胀、卡顿或让聊天上下文变成隐式项目状态。

AGENTS 只记录可复用长期规则，不做逐轮审核日志；README 维护当前状态、authority 和来源入口；具体问题直接修进 canonical / prompt / index / source / script。

如果错误来自 QA、索引生成器、prompt builder、派生图脚本或维护脚本，必须修真正的生成源，不能只改已经生成的输出文件。会把旧口径重新写回来的失效脚本应退出当前维护面。

## 来源入口与 authority

长期项目 README/protocol 可以维护目录/来源级入口地图，例如：路径或来源、状态、用途。状态可按项目需要标为 current、frozen、raw/traceable、historical、obsolete、confusing 等。

README 不维护逐页素材映射；逐页映射放在 canonical、IMAGE_INDEX、MATERIAL_AUDIT 或项目等价文件中。

文件更新时间不是 authority。较新的工作稿可以只负责补数据，较旧但稳定、且被用户指定的正式论文/报告仍可以负责主线。

正文与答疑/附录也分角色：答疑可保留详细审计和边界说明，但不能反向污染正文主线、把探索性结果升级成正式结论，或与正文已确定的证据角色冲突。

## 数据图与 Imagegen 边界

存在结构化原始数据或可靠重建链的数据图，优先程序化/可复现重绘，不让 Imagegen“重画数据”。同一项目、同一语义类别的线图、条形图、散点图、误差棒等应统一字体、坐标轴、网格、线宽、marker、图例层级、数字格式和语义配色。

颜色表示稳定语义角色，但插件不硬编码一套全局色值。论文原始科研图、显微/实验图和没有可靠数据源的正式图，不为了“统一画风”而篡改。

派生数据图应记录来源数据和重建脚本/方法，并实际目视核对成图。

概念/关系图可以参考权威图的科学关系，不要求复刻原图的箭头几何或布局。

## 生成材料包

### 默认整包交付

当一组页面已经具备可生成条件时，默认在开始生成前一次性把这一组页面的材料交付给用户，而不是正常流程中逐页重复发送。

默认把这一组 TXT + 图片打成一个经过校验的 ZIP，并实际交付：

- 聊天文件交付：通过 CCM send_file 或等价文件传输把 ZIP 直接发到当前聊天；
- 手机夸克流程：把同一个 ZIP 上传夸克。

只在工作区里生成 ZIP、不实际交付给用户，不算完成开始生成的材料交付。

整包交付之后：

- 正常生成、检查进度、审核时不重复发送未变化的材料；
- 页面返工时重新给完整当前提示词；
- 只有参考素材变化、canonical 变化、包内容缺失/损坏、交付方式变化或用户明确要求时，才重新发送相关参考图片。

用户如果明确只要某一页，也可以单独交付该页材料。

### Imagegen 参考图格式

Imagegen 参考素材必须是图像文件，例如：

- PNG
- JPG / JPEG
- WebP

PDF 不能直接作为 Imagegen 参考图。

如果权威科研素材只存在于 PDF：

1. 找到实际需要的页或图；
2. 转成图像文件；
3. 实际目视核对转换结果；
4. 检查内容、裁切、分辨率、可读性和科研含义；
5. canonical 和 TXT 提示词改为引用转换后的图像文件；
6. 生成包只放转换后的图像，不放 PDF。

### 生成包校验

仓库提供 scripts/validate-generation-package.ps1，可检查一个生成材料目录或 ZIP：

- 只允许 TXT、PNG、JPG、JPEG、WebP；
- 禁止 MD 和 PDF；
- 至少有一个 TXT 提示词；
- TXT 中引用的图片文件必须实际存在于包内。

## 可选推荐：手机 + 夸克工作流

当 CCM 和夸克上传能力可用时，可以采用以下手机工作流：

1. 在项目侧把所选页范围打成 ZIP，内容只有 TXT 提示词和参考图片；
2. 用 CCM 上传 ZIP 到夸克；
3. 用户在夸克里解压；
4. 需要的参考图片直接从解压目录下载；
5. 打开对应 TXT；
6. 点右上角进入文档模式；
7. 全选并复制提示词；
8. 在新的 GPT ImageGen 会话中粘贴提示词并上传该页指定图片。

这是推荐的移动端便利方案，不是硬依赖。聊天文件交付或用户明确选择的本地目录同样可以使用。

## 持续项目状态

持续项目如果需要跨会话保存当前状态，只维护两个进度：

- 已生成进度：实际生成到的最远页位置；中间缺页由实际生成物判断；
- 连续已通过审核进度：按项目审核顺序连续通过到哪一页。

除这两个值之外，不维护第三套生产进度，也不另建运行状态文件。

项目长期规则、来源口径和当前状态维护在项目 README/protocol；单页内容、布局、素材角色和返修要求维护在对应 canonical spec。

用户反馈改变某一页时，先修改 canonical，再同步当前 TXT 提示词或返工材料。

### 已有 deck 的复用 / 重建判定

整套重排、页码顺延或局部改版时，先判断页面 disposition，而不是默认全部重生成：

- 已通过审核，且页面角色、核心内容、证据角色没有变化：复用；
- 仅页码顺延或章节位置变化：通常仍可复用；
- 首版/当前生成未通过，且没有后续通过版本：重建；
- 从未生成：新建/生成；
- 页面角色、核心内容或证据发生实质变化：重建；
- 不再使用：退役。

`reuse / rebuild / new / retire` 可以存在于项目 plan/index 中，但不是第三套全局生产进度。仍然只维护“已生成进度”和“连续已通过审核进度”两个生产状态。

生成材料包只包含当前真正需要 new/rebuild 的页面；已通过且可复用的页不重复进入生成包。

## 检查进度 / 审核

检查进度时，以项目明确指定的生成物来源为准：

1. 检查实际有哪些页面已经生成；
2. 识别缺页；
3. 从下一个未解决页开始按项目审核规则审核；
4. 更新“已生成进度”和“连续已通过审核进度”；
5. 列出未生成页和需要返工页。

检查进度不会自动再发送下一页材料。需要新的生成包时，由用户明确要求或项目协议明确触发。

如果某一页历史上已经通过审核，但当前找不到正式生成物，应把它报告为“已通过但产物当前不可定位”，而不是把 canonical 文本当成成品，也不应无依据取消其历史审核状态。

## 返工

返工遵循 canonical-first：

1. 实际查看问题页面；
2. 对照当前 canonical 判断问题；
3. 修改最小必要范围；
4. 更新 canonical；
5. 同步一份完整当前 TXT 提示词；
6. 重新判断参考图片是否需要；
7. 只有需要时才重新交付相关参考图片。

返工提示词必须完整可复制，不只给差异补丁。

生成后审核应同时对照实际生成图、当前 canonical、完整当前 prompt 和真实参考素材角色。常见阻断问题包括：科研图角色放错、轴名/单位/数值/公式/图例被改写、必需证据遗漏、不同证据类型混为一谈、虚构项目专属科研图、placeholder/内部管理文字泄漏，或页面已经与当前 canonical 实质漂移。

返工的新版本需要重新审核本体。旧版本的问题是重点回归项，但不能自动决定新版本通过或失败。

## 可选版式示例

仓库提供一个**非权威**的科研中期答辩版式示例：

`skills/content-ppt/references/examples/midterm-defense-layout-example.md`

其中记录 23% / 64% / 9% / 4% 外层分区、白/浅冷灰 + 深海军蓝、结论条、科研小图并排、局部高密度、主次证据层等一套具体做法。

这些全部是具体项目的版式参考，不是通用默认，不进入 workflow hard rule；只有用户明确要参考该风格或项目 protocol 选用它时才读取。

## 插件结构

    plugin.json
    README.md
    AGENTS.md
    .agents/
      plugins/
        marketplace.json
    scripts/
      build-chatgpt-zip.ps1
      validate-generation-package.ps1
    skills/
      content-ppt/
        SKILL.md
        references/
          workflow.md
          image-handoff.md
          ppt-authoring.md
          examples/
            midterm-defense-layout-example.md

这是一个 skills-only plugin，不捆绑自己的 MCP server。

## ChatGPT 插件 ZIP

日常插件交付使用完整插件 ZIP。

在仓库根目录运行：

    .\scripts\build-chatgpt-zip.ps1

生成的 ChatGPT 上传 ZIP：

- ZIP 根目录直接是 plugin.json + skills/；
- 不额外套 content-ppt-pipeline 目录；
- 不包含 .agents/plugins/marketplace.json、README、AGENTS、scripts、.git、dist 等仓库文件；
- plugin.json 必须是 UTF-8 无 BOM。

完成后可通过 CCM send_file 把 ZIP 发送给用户，再由用户上传到 ChatGPT 插件/Skill ZIP 入口。

GitHub / 本地 repo marketplace 仍使用仓库中的 .agents/plugins/marketplace.json，是另一种分发方式。

## Authority 分工

- README.md：用户文档；
- AGENTS.md：维护规则；
- skills/content-ppt/SKILL.md：触发、动作分类、路由和少量全局硬约束；
- skills/content-ppt/references/workflow.md：业务流程 authority；
- skills/content-ppt/references/image-handoff.md：图片检查、生成材料包和 Imagegen 返工 mechanics；
- skills/content-ppt/references/ppt-authoring.md：原生可编辑 PowerPoint 制作与验证。

## 当前版本

当前版本：0.4.0。

本版本在保留现有生成/交付模型的基础上，新增：

- 材料审核先锁定 narrative authority，再用新数据补局部；
- 一个完整材料审核回合一个新会话，跨轮状态落到项目文件；
- 审核发现直接落地，AGENTS 不做逐轮问题日志；
- QA / builder / index / plotting 等生成源与输出同步收口；
- 已有 deck 先做 reuse / rebuild / new / retire 判定，再准备生成包；
- 可复现数据图优先程序化重绘，不交给 Imagegen 伪造；
- 中期答辩具体版式仅作为可选 example，不进入通用 workflow。

原有 hard rules 继续有效：开始生成前整包交付；用户包只包含 TXT + 图片；Imagegen 不接收 PDF 参考图；只维护已生成和连续已通过审核两个进度；正常审核不自动发送新材料；已交付且未变化的整包可复用。

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
2. 校准版式和信息密度；
3. 建立逐页 canonical production spec；
4. 整包自审；
5. 在开始生成前，一次性准备并交付所选页范围的生成材料包；
6. 用户基于该材料包生成页面；
7. 根据实际生成物检查进度并审核；
8. 需要返工的页面更新 canonical 后重新生成；
9. 完成整套 QA 和用户整套审核。

正常生成材料包只包含：

- 每页一个完整 TXT 提示词；
- 该提示词实际需要的参考图片。

canonical Markdown 是项目内部 authority，不放进正常用户生成包，除非用户明确要求项目源文件。

GPT ImageGen 的可复制提示词默认推荐首行使用 @图像生成，帮助目标 GPT 会话明确进入图像生成流程。它只是推荐值，可被用户或具体项目覆盖。

### Native-editable

最终交付以原生可编辑 PowerPoint 为准，不保留 Imagegen 生成像素或其它生成残留。

文字、公式、线条、箭头、结构、图表等优先使用 PowerPoint 原生对象；真实来源图片使用真实素材，数据图尽量从真实数据重绘。

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

当前版本：0.3.0。

本版本将持续项目生产流程统一为：

- 开始生成前整包交付；
- 用户包只包含 TXT 提示词 + 图片；
- Imagegen 不接收 PDF 参考图；
- 只维护已生成和连续已通过审核两个进度；
- 正常审核不自动发送新的页面材料；
- 已交付整包在未变化时直接复用。

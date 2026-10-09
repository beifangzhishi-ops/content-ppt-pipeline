# Content PPT Pipeline

面向 ChatGPT 和 Codex 用户的**证据驱动、内容优先** PowerPoint 工作流 Skill。用于科研答辩、工程报告、课程、技术评审等内容密集型 PPT，强调科研准确性、叙事连贯、真实素材、图表溯源、可编辑施工及逐页和整套审核。

## 当前架构：两个并列的正式运行入口

```text
ChatGPT + CCM ──┐
                ├─> Content PPT Pipeline
Codex native ───┘        │
                         ├─ README / AGENTS / canonical / source index
                         ├─ local scripts / artifacts / Git / QA
                         ├─ optional CPA: one fresh HTTP request per generated slide
                         └─ editable PPTX / rendered review / whole-deck QA
```

- **ChatGPT + CCM**：CCM 提供项目持久工作区、文件、工具执行和 Git；ChatGPT 负责研究、编排与审核。
- **Codex native**：直接使用 Codex 的原生工作区、会话和工具执行能力。与 ChatGPT+CCM 是**并列的一等入口**，不是兼容备选。
- **Content PPT Pipeline**：统一规定内容叙事、证据边界、页面状态、生成门禁、可编辑重建和验收流程。两个宿主使用相同业务规则。
- **CPA**：按需使用的页面视觉生成/重生成后端，不是项目运行时，也不随本 Skill 打包。

## 项目入口与权威材料

每轮开始**实际修改**前：

1. 进入当前 runtime 和既有项目，不另建平行项目目录。
2. 重读当前 README/protocol、AGENTS/AGENT.md。
3. 重新确认项目的**版式/母版 authority**，单页返工默认继承该基准。
4. 打开本轮直接相关的权威材料：博论/论文对应部分、原始科研图、实验记录或现有设计稿。
5. 核对 canonical、唯一 current prompt、来源索引、产物目录、Git 状态。
6. 基于当前项目状态继续，而不是只依赖聊天记录。

长材料按论文、论文章节、实验链或研究模块进行局部深读，并把状态持久化在项目文件中，再做全局审查。单次深读范围是经验性工作方法，不是模型 token 上限。

## 两类生产输出

### CPA 页面视觉生成

`canonical -> synchronized prompt / eligible reference gate -> independent fresh CPA request -> candidate -> visual-stage review -> approved-current 或 rework`

**一页 = 一个独立的 fresh CPA HTTP request。** 每页只传入该页 current prompt 与已实际查看、确属该页的 eligible references。没有参考图时不传；不继承上一页 generation/session/conversation identifier 或请求上下文。可用 bounded parallel queue，但并发请求之间仍完全独立。

生成提示词要分清：

- **必须显示**：标题、正文、公式、数值、引用、标签。
- **视觉职责**：关系、构图、阅读顺序与设计约束——这些不是幻灯片正文。
- **仅核查/施工、不得显示**：内部来源路径、原始网址、溯源备注、审核说明与非显示禁止项，除非 canonical 明确要求可见引用。

正式生成 PNG 不通过脚本擦除、拼接或像素补丁伪造过审；需要结构返工时修正来源/提示词（若确有指令缺陷）并重新走 fresh request。

### ImgGen → 可编辑 PowerPoint

1. 将过审的 ImgGen 成图放在对应幻灯片**最底层，作为临时定位底图**。
2. 在底图上方重建 PowerPoint 原生可编辑文字、公式、表格、科研图、标签、形状和箭头。
3. 模型负责**关键对象可编辑 + 大致定位**；用户依据底图人工调整位置、尺寸和样式，完成后删除底图。
4. 施工阶段底图与对象形成双影**不是缺陷**；不采用隐藏可编辑对象来冒充 editable 的方案。
5. 删除/隐藏底图后，上层对象仍应完整、可读、可选、可修改。真正净稿不能把整页生成位图当作可编辑页面。
6. **真实科研图禁止非等比拉伸**。如果生成布局要求与图像长宽比冲突，调整布局，或回到原数据/绘图代码修改 canvas、axes、legend、字号等后重画，再等比放置；不能扭曲科研证据。

新建或替换重要的 PPT authoring 方法，应先选择有代表性的复杂页面做 end-to-end pilot，实际在目标 PowerPoint 中打开、保存、关闭、重开并检查编辑性，再批量展开。

## 阶段化审核与状态

继续采用集合式页面状态，不使用“审核到 Pxx”或百分比作为持久化进度：

- **approved**：在**明确命名的当前阶段**通过审核；
- **rework / unreviewed**：生成产物存在但尚未通过当前阶段审核；所有新 CPA 结果先进入此集合；
- **not-generated**：此阶段没有当前有效产物。

**CPA/ImageGen 过审 ≠ 可编辑 PPT 过审 ≠ 用户整套终审。** 生成阶段重点审核主体构图、阅读路径、信息层级、核心证据配置和科学关系。错字、局部标签/公式/页码/箭头等若能在下游可靠修复，可记录到现有项目 fix list 后让视觉阶段通过；结构错误、科学关系错误、核心证据错误不能如此延期。所有 deferred fixes 必须在最终 editable 交付前关闭。

candidate 与 approved-current 必须分开；一个文件“存在”不代表“过审”。页面可跳号完成，也可以重排，但已过审页发生关键证据/页面职责变化后必须重新确认适用性。

## 内容、证据与叙事

- **实际项目/科研证据**：真实装置、实验、现场、测量图、模拟结果、定量曲线和特定工程对象，必须来自可追溯的真实来源或从真实数据忠实重建；不能用 CPA 生成貌似真实的替代品。
- **概念示意**：可使用 CPA 解释机制、物理关系、流程、结构和通用设备概念，但不应冒充真实实验记录。
- **背景场景**：无证据职责的通用工程/应用场景允许生成，包括写实风格；但特定已命名设施/事件的事实说明优先真实图片。
- **真实素材优先**：有合适的真实实物图、装置照片、原始结构图时优先采用，不必为了统一视觉而生成仿制品。
- **定量图**：若坐标、数值、色标、误差棒、曲线身份重要，从数据或代码确定性重画，或直接放入真实科研图，不交给 CPA 重解释。
- **观众语言**：正文解释科学/工程含义，不直接展示内部文件夹、人名简称、任务编号。术语首次出现时按听众需要简短解释。
- **直接论证**：优先“明确论点 → 对应证据 → 必要范围边界”，避免无信息的防御性免责声明和过度 hedge。
- **图示语义**：重要箭头必须说明 source → action/relationship → target；不为“画出闭环”加无意义连接。
- **解释力 QA**：不只查事实与版式是否正确，还要问“图说明什么、为什么在这页、支撑什么结论”。三栏、公式框、规则箭头本身不是“代码感”；无功能留白、错字乱码、字体替换、公式出框和异常比例才是实际缺陷。

科研答辩、论文开题/中期/学位答辩还应读取 `skills/content-ppt/references/research-defense.md`，区分研究动机、科学问题、方法、模型比较和证据强度。

## 审核与维护安全

正式生产前完成材料核查与 prompt/reference gate；生成后**实际查看**每张候选图，整套装配后**实际渲染/连读**，不能以文件结构正常或程序测试通过代替视觉审核。

QA/validator **默认只读**：不得在“检查”时暗中修复文件。修复要在明确的 authoring/build 步骤中进行。局部编辑时使用 PPTX/XML 或等价结构检查，防止非目标页面被旧脚本意外改写。只有完成 PowerPoint 应用内打开/保存/重开与对象编辑检查，才能声称已通过目标 PowerPoint 验证。

重要边界、配色/版式规范、页面职责与源索引应在项目 canonical/README/AGENTS 中持久化，不创建重复权威文件；架构切换后清理过时规则和脚本。

## Skill 结构

```text
plugin.json
README.md
AGENTS.md
.agents/plugins/marketplace.json
scripts/build-chatgpt-zip.ps1
skills/content-ppt/
  SKILL.md
  references/
    runtime.md
    workflow.md
    cpa-generation.md
    ppt-authoring.md
    research-defense.md
    examples/midterm-defense-layout-example.md
```

`SKILL.md` 是模型首先读取的简短核心合同；`references/` 各文件分别负责 runtime、通用内容 workflow、CPA 生成、可编辑 PowerPoint 施工和科研答辩特殊规则。examples 只是按需使用的非权威示例。

## 打包与版本

在仓库根目录运行：

```powershell
.\scripts\build-chatgpt-zip.ps1
```

生成 `dist/content-ppt-pipeline-chatgpt-upload-<version>.zip`；ZIP 根目录仅包含 `plugin.json` 与 `skills/`。不得包含 API keys、provider 配置或本地缓存。

**当前版本：0.7.0。** ChatGPT+CCM / Codex native 并列，CPA fresh-request，阶段化过审，ImgGen 底图可编辑施工，科研图比例保护，以及科研答辩专属 reference。

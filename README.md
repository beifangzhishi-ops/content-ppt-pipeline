# Content PPT Pipeline

面向 **ChatGPT Plus** 用户的内容型 PowerPoint 工作流 Skill，重点服务科研汇报、课程、工程报告、技术评审和项目答辩等证据密集型 PPT。

## 当前架构

主实践：

```text
ChatGPT Plus
    -> Content PPT Pipeline
    -> CCM
       -> README / AGENTS
       -> canonical slide specs
       -> current prompts
       -> source / evidence indexes
       -> candidate outputs
       -> approved-current artifacts
       -> scripts / QA
       -> Git
    -> CPA（仅在需要页面视觉生成/重生时）
    -> local candidate -> review -> approved-current
```

兼容路径：

```text
Codex
    -> Content PPT Pipeline
    -> Codex native workspace / execution
    -> CPA（需要生成时）
    -> local candidate -> review -> approved-current
```

角色划分：

- **Content PPT Pipeline**：编排规则、证据规则、页面生命周期、审核门和 PPT 交付规则。
- **CCM**：ChatGPT Plus 主实践中的 durable project runtime，负责 workspace、文件、进程、图片读取和 Git。
- **Codex native runtime**：在 Codex 中直接承担项目运行时，不需要再套 CCM；这条路径会消耗 Codex 使用额度。
- **CPA**：独立的页面视觉生成后端，不是项目 runtime，也不是 Content PPT Pipeline 内置模块。

## 核心运行方式

长期项目默认：

1. 进入当前 runtime / workspace；
2. 读取项目 README / protocol；
3. 读取 AGENTS.md / AGENT.md；
4. 检查 Git 状态；
5. 恢复 canonical、current prompt、source/index 和本地产物状态；
6. 从当前 action 继续，而不是靠旧聊天重建项目。

项目状态由项目文件和实际产物承担。聊天历史只作为交互上下文。

## 两条生产路径

### CPA generation

需要视觉生成的页面走：

`canonical -> prompt/reference gate -> fresh CPA request -> local candidate -> 目视审核 -> approved-current / regeneration`

CPA 不可用时，生成 action 处于 blocked，直到 CPA 恢复。

### Native-editable

最终 PPT 由 PowerPoint 原生可编辑对象、真实图像和数据驱动图表构成，不保留生成页像素作为正式可编辑内容。

## Fresh request

**一页 = 一个 fresh CPA HTTP request。**

每个页面请求只包含：

- 该页自己的 current prompt；
- 该页明确选中的 references；
- 如果该页没有 reference，则不传 reference。

不得向下一页携带：

- 上一页 generation/session/conversation identifier；
- 上一页 request context。

即：

```text
P41 = fresh request
P42 = fresh request
P43 = fresh request
```

并行队列只是同时存在多个独立 fresh request，不改变这个规则。

## 页面状态

不维护“生成到第几页”“连续审核到第几页”或百分比作为 durable state。

页面只维护三个互斥集合：

- **approved**：当前版本已实际目视审核通过；
- **rework / unreviewed**：已有生成物但当前未通过；所有新 CPA 结果先进入这里；
- **not-generated**：当前没有有效生成物。

页面可以乱序生成、乱序审核。前面缺页不阻塞后页 approved。

**page approved 只表示 pipeline-reviewed/current-approved，不等于用户完成最终整套确认。**

## Candidate 与 approved-current

本地产物分两层：

- **candidate**：新生成、待审核、失败或返工中的视觉稿；
- **approved-current**：明确审核通过且仍与当前 canonical/evidence role 一致的版本。

文件存在不等于 approved。

reuse 必须同时满足：

1. 当前页面职责、核心内容和 evidence role 仍有效；
2. 存在明确的 approved-current artifact。

## 证据与生成图边界

### 负责证明链的实践/项目证据

如果图像承担实际项目、实验、装置、测量、仿真结果、现场或其他事实记录的证明职责，**不能用 CPA 生成一个“看起来像真图”的替代品**。

应使用：

- 可追溯的真实来源图；或
- 基于真实数据的忠实、确定性重建。

如果具体命名的真实工厂、现场、实验或案例本身就是事实的一部分，应使用真实来源图，而不是生成相似场景。

### 概念/机理图

可以使用 CPA generation 解释机制、关系、流程、结构或通用装置概念，只要不把生成图表述成真实实验记录或测量结果。

### 工程应用/场景背景图

可以使用生成图，包括写实/摄影感视觉，用于背景、动机、工程应用环境和通用工业场景；前提是它不承担页面事实证明链。

标题、图注和正文不得把生成的场景图包装成真实项目/实验记录。

## CPA reference eligibility

任何给 CPA 的 reference 必须实际查看过。

可以作为事实参考的，是来源可追溯、项目允许且已经目视核验的真实图片。

如果图的证据作用依赖精确保留：

- 坐标；
- 数值；
- 图例；
- 色标；
- 误差；
- series mapping；
- 数字标注；

则不要让 CPA 重新解释。应从真实数据/脚本重建，或保留真实来源图并在 PPT 中直接放置/组合。

默认不作为 CPA reference：

- 旧生成页；
- AI / 生成输出；
- 被拒绝生成页；
- Content PPT Pipeline 生成的示意图；
- 项目脚本生成的演示结构图；
- 临时答辩/报告重绘；
- 内部结构、关系或版式校核图。

用户明确指定的 generated artifact 可以作为 editable reconstruction target，但这不自动使它成为 CPA reference。

PDF 不是直接的 CPA 图片 reference。应把需要的页/图转换成 PNG/JPG/WebP，并实际检查转换结果。

## CPA 生成与返工

默认循环：

`pre-generation gate -> fresh CPA request -> local candidate -> unreviewed -> visual review -> approved/rework -> regenerate -> approved-current`

返工规则：

- 页面渲染不好，但 canonical/prompt 仍正确：直接用完整当前 prompt/reference 做另一个 fresh request；
- 审核发现 canonical、证据映射或 prompt 有真实问题：先修改 owning source，同步完整 current prompt，再重生；
- CPA 鉴权、额度、超时、网络或后端故障：generation blocked，不据此修改 canonical。

CPA 可以使用 bounded parallel queue。每个 in-flight 页面仍是独立 fresh request。

## 三阶段审核

### 1. Material closure

先收口：

- narrative authority；
- 实验 / 工况 / 数据集身份；
- evidence role；
- 数字、单位、分母、样本口径；
- 页面职责；
- 工作量层级。

### 2. Pre-generation gate

CPA 生成前检查：

- canonical 与 current prompt 同步；
- prompt 自包含且可执行；
- 无旧实验名、旧结论、旧版式残留；
- 无隐藏跨页依赖；
- reference 实际看过且 eligible；
- 不要求 CPA 伪造真实科研/工程实践证据或精确定量图；
- PDF reference 已转换为实际图像并检查；
- 每页请求满足 fresh-request 规则。

### 3. Rendered review

实际查看 CPA 返回页和最终 candidate deck：

- 图文是否属于同一实验 / 工况；
- 数字、公式、表格、图例是否正确；
- 是否幻觉新增数据、装置或科研结果；
- 主证据是否足够大、足够可读；
- 装饰是否抢主证据；
- 页面密度和跨页视觉语言是否一致。

材料 QA 和 prompt QA 都不能替代成品目视审核。

## Native-editable PowerPoint

正式可编辑路径优先使用 PowerPoint-native：

- 文本；
- 公式；
- 形状；
- 连接线 / 箭头；
- 图表；
- 表格；
- 简单结构图。

具体规则见 `skills/content-ppt/references/ppt-authoring.md`。

## Skill 结构

```text
plugin.json
README.md
AGENTS.md
.agents/
  plugins/
    marketplace.json
scripts/
  build-chatgpt-zip.ps1
skills/
  content-ppt/
    SKILL.md
    references/
      runtime.md
      workflow.md
      cpa-generation.md
      ppt-authoring.md
      examples/
        midterm-defense-layout-example.md
```

职责：

- `SKILL.md`：模型首先读取的 runtime/backend contract、core contract 和 action routing；
- `runtime.md`：ChatGPT+CCM / Codex runtime routing、离散状态、本地产物、Git；
- `workflow.md`：内容、证据、页面职责和 deck 生命周期；
- `cpa-generation.md`：CPA generation、fresh request、reference gate、并行队列、审核和重生；
- `ppt-authoring.md`：native / editable PPT 构建；
- `examples/`：非权威示例。

## ChatGPT 安装 ZIP

在仓库根目录运行：

```powershell
.\scripts\build-chatgpt-zip.ps1
```

生成：

`dist/content-ppt-pipeline-chatgpt-upload-<version>.zip`

ZIP 根目录只包含：

- `plugin.json`
- `skills/`

## 当前版本

**0.6.0**

当前版本重点：

- ChatGPT Plus + CCM 作为主实践，Codex native runtime 作为兼容路径；
- CCM runtime 与 CPA generation backend 的依赖关系明确分离；
- 每页 CPA generation 强制 fresh HTTP request；
- 清理已退役工作流和旧 authority naming 残留；
- 保留并强化真实实践证据与可生成概念/工程场景图的边界；
- 使用离散 page state 和 approved-current artifact；
- native-editable 与 CPA reference 边界明确。

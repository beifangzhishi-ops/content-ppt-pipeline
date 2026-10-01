# Content PPT Pipeline

面向 **ChatGPT Plus** 用户的内容型 PowerPoint 工作流 Skill，重点服务科研汇报、课程、工程报告、技术评审和项目答辩等证据密集型 PPT。

当前产品架构是：

```text
ChatGPT Plus / GPT
        │
        ▼
Content PPT Pipeline
        │
        ▼
CCM workspace
├─ README / AGENTS
├─ canonical slide specs
├─ current prompts
├─ source / evidence indexes
├─ candidate outputs
├─ approved-current artifacts
├─ scripts / QA
└─ Git
        │
        ▼
CPA ImageGen
        │
        ▼
local candidate → review → approved-current
```

GPT 负责理解、研究、审核和调度；CCM workspace 是长期项目的 durable runtime；CPA ImageGen 是 Imagegen-assisted 的正式生产后端。ChatGPT Library 不承担生产状态、成品索引或跨会话恢复职责。

## 核心运行方式

长期项目默认：

1. 进入已选 CCM workspace；
2. 读取项目 README / protocol；
3. 读取 AGENTS.md / AGENT.md；
4. 检查 Git 状态；
5. 恢复 canonical、prompt、source/index 和本地产物状态；
6. 继续当前 action，而不是靠旧聊天恢复项目。

新会话正常恢复项目不需要 Library，也不需要重放历史聊天。

## 两种生产模式

### Imagegen-assisted

CPA ImageGen 是唯一正式生成链：

`canonical → prompt/reference gate → CPA → 本地 candidate → GPT 目视审核 → approved-current / 重生`

如果 CPA 不可用，生成 action 记为 blocked；不自动切回人工上传/下载路线。

### Native-editable

最终 PPT 由 PowerPoint 原生可编辑对象、真实图像和数据驱动图表构成，不保留 Imagegen 像素式页面作为正式可编辑内容。

## 页面状态

不维护“生成到第几页”“连续审核到第几页”或百分比作为 durable state。

页面只维护三个互斥集合：

- **approved**：当前版本已由 pipeline 实际目视审核通过；
- **rework / unreviewed**：已有生成物但当前未通过；所有新 CPA 结果先进入这里；
- **not-generated**：当前还没有本轮视觉稿。

页面可以乱序生成、乱序审核。前面缺页不阻塞后页 approved。

**page approved 只表示 pipeline-reviewed/current-approved，不等于用户已经完成最终整套确认。**

## Candidate 与 approved-current

本地产物分两层：

- **candidate**：新生成、待审核、失败或返工中的视觉稿；
- **approved-current**：明确审核通过且仍与当前 canonical/evidence role 一致的版本。

文件存在不等于可复用。

reuse 必须同时满足：

1. 当前页面职责、核心内容和 evidence role 仍有效；
2. 存在明确的 approved-current artifact。

## CPA 返工规则

不再维护复杂“返工归因”分类。

规则只有：

- 页面渲染不好，但 canonical/prompt 仍正确 → 直接 CPA 重生；
- 审核确实发现 canonical、证据映射或 prompt 有真实问题 → 修 owning source，完整同步 prompt，再重生；
- CPA 鉴权、额度、超时、网络或后端故障 → generation blocked，不作为页面内容结论，也不据此修改 canonical。

## CPA 并行队列

CPA 可以异步并行：

- 多页同时 in-flight；
- 某页等待生成时准备下一页；
- 返图按返回顺序审核；
- 失败页可以修改 prompt 后重生；
- approved 页及时归档；
- 页面状态与页码顺序解耦。

并发上限由当前 CPA/provider、额度、限流和项目协议决定，Skill 不写死固定槽位数。

如果连续出现同类视觉错误，应暂停扩大队列，先修共因。

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

- canonical 与 prompt 同步；
- prompt 自包含且可执行；
- 无旧实验名、旧结论、旧版式残留；
- 无隐藏跨页依赖；
- reference 实际看过且 eligible；
- 不要求 ImageGen 伪造真实科研证据或定量图；
- PDF 已转换成实际图像并检查。

### 3. Rendered review

实际看 CPA 返回页和最终候选 deck：

- 图文是否属于同一实验 / 工况；
- 数字、公式、表格、图例是否正确；
- 是否幻觉新增数据、装置或科研结果；
- 主证据是否足够大、足够可读；
- 装饰是否抢主证据；
- 页面密度和跨页视觉语言是否一致。

材料 QA 或 prompt QA 都不能替代成品目视审核。

## 审核优先级

默认从高到低：

1. 叙事连贯与科学 / 领域正确；
2. 证据来源、身份、角色和独立性；
3. 数字 / 公式 / 统计口径一致；
4. 页面职责与正文 / Q&A 边界；
5. 可追溯工作量表达；
6. reference eligibility 与 prompt 可执行性；
7. 真实生成页的证据可读性、布局和跨页一致性；
8. 单页装饰性美观。

## 证据强度规则

常见边界：

- 同一数据集模型比较 ≠ 独立验证；
- 同一实验链连续事件 ≠ 自动等于独立重复实验；
- 参数扫描 / 敏感性 ≠ 上游状态到参数的独立定量标定；
- 给定边界 / 输入历史 ≠ 模型预测并验证的输出；
- 派生量 ≠ 直接实测；
- verification / external validation / external reference / consistency check / numerical audit / model discrimination 不得互相升级。

标题和结论的证据强度必须与正文一致。

## 页面职责与 Q&A

每页只承担一个主要问题。

标题、主证据、底部结论应回答同一个问题。

正文承载主叙事；Q&A / appendix 承载正文不展开但答疑时可能需要的进阶证据。Q&A 不能反向污染正文，也不能把探索性结果升级成正式主结论。

## 工作量表达

只用真实、可追溯证据展示工作量，例如：

- 重复事件；
- 轨迹；
- 帧数；
- 样本数；
- 参数扫描；
- 网格；
- 统计窗口；
- 多尺度 / 多工况计算。

如果工作量展示与叙事冲突，优先保证叙事，再压缩 / 重组工作量呈现。

## CPA reference eligibility

任何给 CPA 的 reference 必须实际查看过。

### 可以作为事实参考

来源可追溯、项目允许且已经目视核验的：

- 真实实验 / 装置照片；
- 真实现场 / 对象图；
- 用于定性事实的论文 / 来源图；
- 只提供物理语境、不要求 CPA 保留精确数值的测量 / 数值图像。

### 精确定量证据默认不进 CPA

如果图的证据作用依赖精确保留坐标、数值、图例、色标、误差或 series mapping：

- 从真实数据 / 脚本可复现生成；
- 或保留真实来源图；
- 最终直接 native / post-composite 到 PPT；
- 不让 ImageGen 重新解释这些定量元素。

### 默认禁止作为 CPA reference

- 旧生成页；
- ImageGen / AI 输出；
- 被拒绝生成页；
- Content PPT Pipeline 生成的示意图；
- 项目脚本临时重绘的答辩示意；
- 内部结构 / 关系校核图。

这些可以内部诊断，但默认不递归进入下一轮 CPA。

## 概念图

概念 / 机制 / 流程图根据 canonical 的节点和关系重新构图，不继承旧生成图的几何。

默认优先：

- 短连接；
- 水平 / 垂直；
- 90° 折线。

避免无必要的长斜箭头、跨模块对角线和多重交叉。

## Native-editable PowerPoint

正式可编辑模式优先使用 PowerPoint-native：

- 文本；
- 公式；
- 形状；
- 连接线 / 箭头；
- 图表；
- 表格；
- 简单结构图。

生成页可以在用户明确指定时作为 **editable reconstruction target**，但这不等于它可以作为 CPA ImageGen reference。

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
      ccm-runtime.md
      workflow.md
      image-generation.md
      ppt-authoring.md
      examples/
        midterm-defense-layout-example.md
```

职责：

- `SKILL.md`：模型首先读取的 core contract + action routing；
- `ccm-runtime.md`：CCM runtime、离散状态、本地产物、Git；
- `workflow.md`：内容、证据、页面职责和 deck 生命周期；
- `image-generation.md`：CPA production、reference gate、并行队列、审核和重生；
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

**0.5.1**

当前版本重点：

- CPA ImageGen 是 Imagegen-assisted 唯一正式生产链；
- regeneration 使用单一“源有错才改，否则重生”规则；
- `SKILL.md` 采用 core contract + action routing，减少模型漏读；
- 定量证据与 CPA reference 边界明确；
- editable reconstruction target 不等于 CPA reference；
- page approved 与用户最终 whole-deck review 是两层语义。

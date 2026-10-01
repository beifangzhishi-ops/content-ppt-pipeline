# Content PPT Pipeline

面向 **ChatGPT Plus** 用户的内容型 PowerPoint 工作流 Skill，重点服务科研汇报、课程、工程报告、技术评审、项目答辩等证据密集型 PPT。

0.5.0 的默认产品架构是 **Plus + CCM-first**：

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
direct image-generation backend
推荐：CPA ImageGen
```

GPT 负责理解、研究、审稿、决策和调度；CCM workspace 是长期项目的 durable runtime；CPA ImageGen 是推荐的直接生成后端。ChatGPT Library 不再承担生产状态、成品索引或跨会话恢复职责。

## 推荐部署

推荐组合：

- **ChatGPT Plus**：主交互、推理、研究、审核和流程调度；
- **Content PPT Pipeline**：PPT 方法论、canonical、证据、prompt/reference gate、状态与 QA；
- **CCM**：项目工作区、本地执行、状态恢复、脚本、Git、生成产物与成品归档；
- **CPA ImageGen**：推荐 direct-generation backend，直接提交 prompt/reference 并把结果落回本地项目。

CPA 是推荐方案，不是安装硬依赖。Plus 订阅也不等于自动拥有 CPA/API 权限。没有 direct backend 时，可以降级到手工 ChatGPT ImageGen handoff。

## 两种生产模式

### Imagegen-assisted

默认优先走 **direct generation**：

1. 从当前 canonical 生成/同步本页 prompt；
2. 检查 reference eligibility；
3. 由可用、已授权的 direct backend 提交生成；
4. 结果直接落到 CCM 本地项目；
5. 新结果先进入“未过审”；
6. GPT 实际目视审核；
7. 通过则进入 approved-current；
8. 失败则判断根因并自动返工。

推荐 CPA ImageGen 作为这一执行后端。

只有以下情况才走 manual handoff：

- direct backend 不可用；
- 鉴权、额度、限流或网络持续异常；
- 用户明确要自己生成。

此时才打包/交付 prompt TXT + 合格参考图。

### Native-editable

最终 PPT 必须由 PowerPoint 原生可编辑对象、真实图像和数据驱动图表构成，不保留 Imagegen 像素式页面作为正式可编辑内容。

## CCM-first 项目运行时

长期项目默认以 CCM workspace 为唯一生产 runtime。

进入/恢复项目时：

1. 进入已选 CCM workspace；
2. 读取项目 README / protocol；
3. 读取 AGENTS.md / AGENT.md；
4. 检查 Git 状态；
5. 读取当前任务需要的 canonical、prompt、source/index 与本地产物；
6. 从项目文件恢复状态，而不是依赖聊天历史。

新会话正常恢复项目时，不需要 Library 同步，也不需要重放旧聊天。

ChatGPT Library 只有在用户主动提供/指定某个 Library 文件时，才作为普通外部输入源处理。

## 页面状态

0.5.0 不再维护：

- “已经生成到第几页”；
- “连续审核通过到第几页”；
- “审核完成百分比”作为 durable state。

页面只维护三个互斥集合：

- **approved / 过审**：当前版本已经实际目视审核通过；
- **rework / 未过审**：已经有生成物，但当前版本尚未通过；刚生成的新稿也先进入这里；
- **not-generated / 未生成**：当前还没有本轮视觉稿。

页面可以乱序生成、乱序审核。P02 未生成，不会阻塞 P03 进入 approved。

张数和百分比可以临时汇报，但不是项目 authority。

## Candidate 与 approved-current

本地产物分两层：

- **candidate**：新生成、待审核、失败或返工中的视觉稿；
- **approved-current**：明确审核通过、仍与当前 canonical/evidence role 一致的版本。

“文件存在”不等于“可以复用”。

reuse 必须同时满足：

1. 当前 canonical / 页面职责 / evidence role 没有实质变化；
2. 存在明确的 approved-current artifact。

失败稿不得因为还在目录里就进入最终 PPT。

## 返工先判根因

生成失败后，不要立刻改 canonical。先判断：

### 1. canonical / evidence / prompt defect

源规范或证据映射本身有错。

先改 owning source，再同步 prompt，再重生成。

### 2. generation execution/input mismatch

例如：

- 用错 Pxx prompt；
- 传错参考图；
- 漏传参考图；
- 串页；
- 结果挂错页。

这类属于执行失配。直接用正确材料重生，**不要为了适配错误生成物反改 canonical**。

### 3. model rendering defect

输入正确，但模型把文字、公式、布局、示意关系或视觉约束执行错。

先重生成；只有发现 prompt 确实存在可复现歧义时，才加强 prompt。

### 4. infrastructure/provider failure

鉴权、超时、EOF/5xx、限流、网络异常等属于执行基础设施故障，不算页面内容“未过审”，更不能据此修改 canonical。

## Direct-generation 并行队列

direct generation 不要求一张完全结束后才能下一张。

可以维护受控的小型 in-flight queue：

- 一页等待生成；
- 一页返回待审；
- 一页返工重生；
- 同时准备下一页。

并发上限由当前 provider、额度、限流与项目协议决定，Skill 不写死固定槽位数。

如果连续出现同类视觉错误，应暂停扩大队列，先修共因，避免批量制造返工。

## 三阶段审核模型

### 1. Material closure

先收口：

- narrative authority；
- 实验/工况/数据集身份；
- evidence role；
- 数字、单位、分母、样本口径；
- 页面职责；
- 工作量层级。

### 2. Pre-generation gate

生成前检查：

- canonical 与 prompt 同步；
- prompt 自包含且可执行；
- 无旧实验名、旧结论、旧版式残留；
- 无“same as previous slide”这类隐藏依赖；
- 参考图实际查看过；
- reference eligibility 正确；
- 不要求 Imagegen 伪造真实科研证据或定量图；
- PDF 已转换成实际图像并检查。

### 3. Rendered review

实际看生成页/候选 deck：

- 图文是否属于同一实验/工况；
- 数字、公式、表格、图例是否正确；
- 有没有幻觉新增数据、装置或科研结果；
- 主证据是否足够大；
- 装饰是否抢主证据；
- 页面密度、视觉语言、跨页一致性是否合格。

**材料审核通过、prompt QA 通过、generation-package validator 通过，都不能替代成品目视审核。**

## 证据强度规则

默认审核优先级：

1. 叙事连贯与科学/领域正确；
2. 证据来源、角色、身份和独立性；
3. 可追溯工作量表达；
4. 全套视觉一致性；
5. 单页装饰性美观。

常见边界：

- 同一数据集模型比较 ≠ 独立验证；
- 同一实验链连续事件 ≠ 自动等于独立重复实验；
- 参数扫描/敏感性 ≠ 上游状态到参数的独立定量标定；
- 给定边界/输入历史 ≠ 模型预测并验证的输出；
- 派生量 ≠ 直接实测；
- verification / external validation / external reference / consistency check / numerical audit / model discrimination 不得互相升级。

标题和结论的证据强度必须与正文一致。

## 页面职责与 Q&A

每页只承担一个主要问题：

- 标题；
- 主证据；
- 底部结论；

三者应属于同一职责。

次级审计、敏感性或边界检查不能抢主证据角色。

正文承载主叙事。Q&A / appendix 是“正文不展开，但答疑时可直接调出的进阶证据层”，不能反向污染正文，也不能把探索性结果升级成正式主结论。

## 工作量表达

工作量只能用真实、可追溯证据表达，例如：

- 重复事件；
- 轨迹；
- 帧数；
- 样本数；
- 参数扫描；
- 网格；
- 统计窗口；
- 多尺度/多工况计算。

工作量展示与叙事冲突时，优先保证叙事，再压缩/重组工作量呈现。

## Imagegen reference eligibility

### 可以作为事实参考

经过实际目视核验、来源可追溯且项目允许上传的：

- 真实实验图；
- 装置图；
- 测量/结果图；
- 论文图；
- 真实现场/对象图；
- 可追溯数值结果图。

这些图提供事实，不提供“复制它的画风”的权限。

### 默认禁止作为下一轮 Imagegen reference

- 旧生成页；
- Imagegen/AI 输出；
- 被拒绝生成页；
- Content PPT Pipeline 自己生成的示意图；
- 项目脚本临时重绘的答辩示意；
- 内部结构/关系校核图。

这些可以内部诊断，但不再递归进入下一轮图生图。

### 定量图

定量图属于 evidence：

- 从真实数据/脚本可复现生成；
- 保留 provenance；
- 最终 PPT 直接放置或 native/post-composite；
- 不让 Imagegen 重新解释坐标、数字、图例。

## 概念图

概念/机制/流程图根据 canonical 的节点和关系重新构图，不继承旧生成图的布局。

默认优先：

- 短连接；
- 水平/垂直；
- 90°折线；

避免无必要的：

- 长斜箭头；
- 跨模块对角线；
- 多重交叉连线。

这只是默认可读性规则，不是固定配色或版式。

## Manual handoff fallback

只有 direct generation 不可用或用户明确要求时才走手工交付。

生成包只包含：

- 当前完整 prompt TXT；
- 当前真正需要且 eligible 的 PNG/JPG/JPEG/WebP 参考图。

不包含：

- canonical MD；
- PDF；
- 旧生成页；
- Pipeline 派生示意；
- 内部结构图；
- 被拒绝页。

`scripts/validate-generation-package.ps1` 只检查包结构、缺图引用、重复 basename 等，**不证明 provenance/reference eligibility**。

ZIP、chat-file、Quark 都是 fallback delivery surface，不再是默认主生产路线。

## Native-editable PowerPoint

正式可编辑模式优先使用 PowerPoint-native：

- 文本；
- 公式；
- 形状；
- 线条/箭头；
- 图表；
- 表格；
- 简单结构图。

真实科研图保持真实来源，数据图保持可复现。

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
  validate-generation-package.ps1
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

- `SKILL.md`：GPT action routing + 全局 hard rules；
- `ccm-runtime.md`：CCM-first 项目 runtime、状态、本地产物、Git；
- `workflow.md`：PPT 内容、证据、页面职责、生产生命周期；
- `image-generation.md`：direct generation、CPA 推荐路线、reference gate、并行队列、审核、返工、handoff fallback；
- `ppt-authoring.md`：native/editable PPT 构建与验证；
- `examples/`：非权威示例，只在用户/项目明确选用时读取。

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

不会包含 README、AGENTS、scripts、.git、marketplace 等仓库维护文件。

## Authority 分工

- `README.md`：用户可见当前产品定位与使用说明；
- `AGENTS.md`：仓库维护规则；
- `skills/content-ppt/SKILL.md`：Skill 总路由与 hard rules；
- `references/ccm-runtime.md`：CCM runtime authority；
- `references/workflow.md`：业务流程 authority；
- `references/image-generation.md`：Imagegen production authority；
- `references/ppt-authoring.md`：PowerPoint authoring authority。

## 当前版本

**0.5.0**

主要变化：

- 明确面向 ChatGPT Plus，建立 CCM-first 架构；
- CCM workspace 成为默认 durable project runtime；
- CPA ImageGen 成为推荐 direct-generation backend；
- direct generation 从可选支线升级为 Imagegen-assisted 主路线；
- ChatGPT Library 退出默认生产状态/成品链；
- 页面状态改成 approved / rework / not-generated 离散集合；
- candidate 与 approved-current 本地产物分层；
- 返工先区分源规范、执行错配、模型渲染和基础设施故障；
- 增加 material closure → pre-generation gate → rendered review 三阶段；
- 加强证据强度、页面职责、Q&A 边界和工作量表达；
- 禁止旧生成图/Pipeline 派生图递归成为 Imagegen reference；
- manual ZIP/Quark handoff 降级为 fallback。

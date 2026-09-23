# Content PPT Pipeline

一个面向重内容型 PPT 的 ChatGPT / Codex 工作流插件。

它主要服务于科研汇报、课程教学、工程/技术报告、项目汇报、设计评审、方案说明以及其它需要检索资料、组织证据、设计故事线、校准版式和信息密度、逐页生产与返修的演示文稿。

它不是以“华丽美化、营销海报、品牌宣传”为主要目标的视觉设计插件。核心目标是：

- 内容正确、来源可靠；
- 结构清楚、每页目的明确；
- 信息密度与正式程度匹配场景；
- 真实图片和数据可追溯；
- 生成页经过逐页审核；
- 最终 PowerPoint 尽可能原生、可编辑；
- 整套交付前进行全局 QA。

## 适用场景

典型场景包括：

- 论文、课题、中期、答辩、学术报告；
- 课程讲义、课堂展示、教学汇报；
- 工程分析、技术报告、设计评审；
- 项目汇报、方案说明、数据密集型 briefing；
- 基于论文、实验、仿真、工程图、公式、数据、真实图片制作 PPT；
- 继续、返修或重构已经开始的重内容型 PPT 项目。

如果任务只是“把现有 PPT 做得更炫、更像广告、更品牌化”，这套工作流通常不应成为主要流程。

## 两种生产模式

### Imagegen-assisted

允许 Imagegen 参与逐页视觉生成或辅助生产。

插件会先完成资料理解、版式/密度校准、逐页 production spec 和整包自审，再逐页 handoff；用户返回生成结果后，由 GPT 直接判断接受还是重做，并继续推进下一页。

### Native-editable

最终交付以原生可编辑 PowerPoint 为准，不保留 Imagegen 生成像素或其它不可编辑生成残留。

文字、公式、线条、箭头、结构、图表等优先使用 PowerPoint 原生对象；真实来源图片使用原图，数据图尽量从真实数据重绘。

## 插件结构

    plugin.json
    README.md
    AGENTS.md
    .agents/
      plugins/
        marketplace.json
    skills/
      content-ppt/
        SKILL.md
        references/
          workflow.md
          image-handoff.md
          ppt-authoring.md

这是一个 skills-only plugin，不捆绑自己的 MCP server。

某些完整工作流动作会使用已经安装在环境里的通用工具。例如，在需要把参考图实际交付到聊天时，当前流程使用 CCM 的文件传输能力。插件本身不复制实现这些底层工具。

## 安装

本仓库按 OpenAI 当前 portable Agent Plugins 格式组织，根目录 plugin.json 是 canonical manifest。

### 推荐交付方式：ZIP 上传到 ChatGPT

本项目日常交付以完整插件 ZIP 为主。

每次实现或更新完成后，维护流程是：

1. 完成源码修改和必要检查。
2. 在仓库根目录运行：

       .\scripts\build-chatgpt-zip.ps1

   脚本会生成 **ChatGPT 上传专用 ZIP**：ZIP 根目录直接放 plugin.json 和 skills/，不再额外套一层 content-ppt-pipeline/ 目录。
3. ChatGPT 上传包保持最小化：只包含 `plugin.json` 与 `skills/`。**不要**把 `.agents/plugins/marketplace.json`、README、AGENTS、`.git/`、临时文件、构建缓存或旧 ZIP 包进上传包。
4. 通过 CCM `send_file` 把最新 ZIP 直接发送给用户。
5. 用户在 ChatGPT 的插件/Skill ZIP 上传入口上传这个 ZIP，用于云端安装或更新。

因此，正常情况下用户不需要自己去本机项目目录找文件，也不需要手工复制源码到其它插件目录。

ChatGPT ZIP 上传和 repo marketplace 是两种不同分发物：

- ChatGPT 上传 ZIP：ZIP 根目录直接是单个 plugin root，即根 `plugin.json` + `skills/`；不含 `.agents/plugins/marketplace.json`。
- GitHub / 本地 marketplace：保留仓库里的 `.agents/plugins/marketplace.json`，用于发现和安装插件。

打包脚本还会检查 plugin.json 不能带 UTF-8 BOM、至少存在一个 skills/<name>/SKILL.md，并对 ZIP 内部路径做最小布局校验。

### 从 GitHub Repo Marketplace 安装

仓库发布到 GitHub 后，同事可以把仓库添加为 marketplace source：

    codex plugin marketplace add owner/repo

需要固定分支时：

    codex plugin marketplace add owner/repo --ref main

然后在支持 repo marketplace 的 ChatGPT 桌面端 / Codex 插件目录中选择 Content PPT Pipeline 安装。

不同 ChatGPT surface 对 repo marketplace 的支持可能不同。发布版本应在这里记录实际验证过的客户端。

### 本地测试

在本仓库根目录下，可直接把本地目录作为 marketplace source：

    codex plugin marketplace add .

修改插件后刷新 marketplace，并按客户端要求重新启动/刷新插件目录。

## CCM 依赖说明

插件安装本身不要求 CCM。

但当工作流明确需要以下动作时，如果环境没有等价能力，就不能假装该动作已经完成：

- 实际查看用户侧或外部项目图片；
- 把参考图文件实际发送进当前聊天；
- 访问只存在于用户侧工作区的来源文件；
- 执行 CCM 专属文件动作。

尤其是 Imagegen handoff：路径或文件名不等于文件交付。需要参考图时，参考图必须先被实际查看，再通过文件传输能力成功发送，并和完整提示词在同一轮交付。

## 使用方式

直接描述你的 PPT 任务即可，例如：

- “根据这篇论文和实验数据做一个 15 页中期汇报。”
- “把这套工程评审材料整理成正式 PPT，先搜资料和定结构。”
- “继续上一轮的第 7 页，审核我刚生成的图。”
- “把接受的页面重构成全可编辑 PowerPoint。”
- “整套再审一遍，检查数字、术语、图片和重复内容。”

Skill 会根据当前请求和当前工件判断正在执行的动作，只加载当前需要的详细 reference，而不是每轮机械加载全部规则。

## 更新与维护

- 用户文档放在本 README。
- Agent / 维护者规则放在 AGENTS.md。
- 工作流入口和动作分类放在 skills/content-ppt/SKILL.md。
- 详细业务流程放在 references/workflow.md。
- Imagegen 图片检查、参考图发送和 handoff 规则放在 references/image-handoff.md。
- 原生可编辑 PowerPoint 制作规则放在 references/ppt-authoring.md。

版本使用 Semantic Versioning。行为兼容的新能力提升 minor，修正规则使用 patch；破坏已有工作流或结构时提升 major。

## 当前状态

当前为 0.1.0 初始迁移版本。

## 本机 Codex 安装验证（开发用途）

本项目已在 Windows 上通过 Codex CLI 从当前正式源码目录直接注册并安装，不需要复制源码到其它插件目录。

当前本地 marketplace 名称为 `content-ppt-pipeline-repo`，插件选择器为 `content-ppt-pipeline@content-ppt-pipeline-repo`。

### 首次注册与安装

在正式源码目录存在的前提下，先注册本地 marketplace：

```powershell
codex plugin marketplace add C:\Users\noha\Documents\AAAVitalFile\ppt-pipeline-plugin
```

然后安装插件：

```powershell
codex plugin add content-ppt-pipeline@content-ppt-pipeline-repo
```

安装后 Codex 会把一个运行副本写入自己的插件 cache；正式源码仍只维护本仓库这一份。

### 每次源码更新后的刷新

修改 `SKILL.md`、references、README、`plugin.json` 等插件源码后，需要再次执行：

```powershell
codex plugin add content-ppt-pipeline@content-ppt-pipeline-repo
```

已实机验证：即使版本号仍是 `0.1.0`，重复执行这条命令也会重新复制当前正式源码并刷新已安装 cache，不需要先 `remove`。

刷新后重新打开/重启 ChatGPT Desktop，再用新会话验证最新插件行为。

注意：

- `codex plugin marketplace upgrade` 只用于刷新 Git marketplace snapshot，不是本地目录插件的更新命令。
- 本地开发更新时，使用上面的 `codex plugin add ...` 重新刷新安装副本。
- `plugin.json` 和 `.agents/plugins/marketplace.json` 必须保持 UTF-8 无 BOM；当前 Codex CLI 会拒绝带 BOM 的 marketplace JSON。

这套 Codex CLI 流程用于本地开发和验证；面向用户的默认交付仍是“完成更新 -> 打 ZIP -> 通过 CCM `send_file` 发送 -> 在 ChatGPT 上传 ZIP”。
